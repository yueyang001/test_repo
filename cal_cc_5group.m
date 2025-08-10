data = xlsread('IVC_DATA.xlsx');  % 读取数据
% data = xlsread('IVC_DATA0.xlsx');

y_true = data(:, 1);  % 第一列为人工评分
y_pred = data(:, 3);  % 第三列为模型预测评分的相反数
% y_pred = data(:, 2);  % 第二列为模型预测评分

group_size = 5;  % 每组数据数量
num_samples = length(y_true);
num_samples;
num_groups = floor(num_samples / group_size);  % 计算总共可以分成几组

% 初始化数组用于保存每组的相关系数
srocc_all = zeros(num_groups, 1);
krocc_all = zeros(num_groups, 1);
plcc_all  = zeros(num_groups, 1);

for i = 1:num_groups
    idx_start = (i - 1) * group_size + 1;
    idx_end = i * group_size;

    y_true_group = y_true(idx_start:idx_end);
    y_pred_group = y_pred(idx_start:idx_end);

    srocc_all(i) = corr(y_true_group, y_pred_group, 'Type', 'Spearman');
    krocc_all(i) = corr(y_true_group, y_pred_group, 'Type', 'Kendall');
    plcc_all(i)  = corr(y_true_group, y_pred_group, 'Type', 'Pearson');
%     计算每组的值
    fprintf('Group %d:\n', i);
    fprintf('  SROCC = %.4f\n', srocc_all(i));
    fprintf('  KROCC = %.4f\n', krocc_all(i));
    fprintf('  PLCC  = %.4f\n\n', plcc_all(i));
end
% % 计算平均值
% avg_srocc = mean(srocc_all);
% avg_krocc = mean(krocc_all);
% avg_plcc  = mean(plcc_all);
% 
% fprintf('Average SROCC = %.4f\n', avg_srocc);
% fprintf('Average KROCC = %.4f\n', avg_krocc);
% fprintf('Average PLCC  = %.4f\n', avg_plcc);
% 计算 平均值、中位数、众数
fprintf('=== SROCC ===\n');
fprintf('Mean平均数:  %.4f\n', mean(srocc_all));
fprintf('Median中位数: %.4f\n', median(srocc_all));
fprintf('Mode众数:  %.4f\n', mode(srocc_all));

fprintf('\n=== KROCC ===\n');
fprintf('Mean平均数:  %.4f\n', mean(krocc_all));
fprintf('Median中位数: %.4f\n', median(krocc_all));
fprintf('Mode众数:  %.4f\n', mode(krocc_all));

fprintf('\n=== PLCC ===\n');
fprintf('Mean平均数:  %.4f\n', mean(plcc_all));
fprintf('Median中位数: %.4f\n', median(plcc_all));
fprintf('Mode众数:  %.4f\n', mode(plcc_all));
