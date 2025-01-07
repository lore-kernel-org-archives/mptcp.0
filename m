Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F918B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269789; cv=none; b=qobEC7kaUXdRcXI6ob34R9WAsEQAfOUSdkooT2LRCfCz1GO+9MjJ+NtvP/nX1tBePO6rKqmp6SYlC4H0+l6cu+jewOMe61Dk/1k2nDD0IcFSBCMdsCvs6fsEuFR3jdq5MfHo5E2AjPhNsANGU39oYD9y23EDvbqhIEJvKR46m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269789; c=relaxed/simple;
	bh=YNsnG3ADZJamkUbdpaE8uWMY9uNqUDsFg7dIblUlRiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNp1RIjcuL9rdtyNHtI8i5TMZs6AHDHRP1GNQ43S3MaWjAcHgn1sEE+f8N93f2q3So8rzwY0WNxbLcgWVCzhxvtvYxDLZplIsZQUuNlB7HRn8Qjzz/5fLDDMMDLOsVVaK2XG4voZj5ue3mbNFP4T5wjDaZFwNFWHsRUjlskWMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B65XMAdL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B65XMAdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E222C4CED6;
	Tue,  7 Jan 2025 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269788;
	bh=YNsnG3ADZJamkUbdpaE8uWMY9uNqUDsFg7dIblUlRiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B65XMAdLxBLF3N5jiPlcqKQfFB8rPy+hCXzWtnyB0api30X/Fm587iVtPc4TKEv/h
	 dhzf3ZOFqfzbGj5zsewfuZK8Uzgrl2szaQzdmQKqmcXKOnblKE0LZl+WwYWHY1QP9l
	 zs6jRweJW9R6nhOMqLeT3WlEfSLp3k/L1ISSw7rI95heVcmzTCVue93dmZy7ExzZfZ
	 MXbTg7UFEgjw5dYhOmD/xKjCultxnKmZwlWka8KcSwwV6TghSvuHhxvhsKlWOUegms
	 kLsUYEGZG9dsS6QjvsRV+I1WR8zeuLTfTIQCfPVokpsJ1SMKch+AsdR0QtqtPL/APq
	 qw2fNmgx1Hc0w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:25 +0100
Subject: [PATCH mptcp-net 1/9] mptcp: sysctl: avail sched: remove write
 access
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-1-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YNsnG3ADZJamkUbdpaE8uWMY9uNqUDsFg7dIblUlRiw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/aQq8G9lCB69F2jur9iNCdDfq8xe4Mz6OVc
 ystIH6F5NaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 czVHEACb56zAGKhzeIYQRYtou6smNZgn+N+KyFiDGkOuyqEJgLGvimLBFPDO97rCNC6Fq8jxESn
 TqpHdhkaoeQsn9/Kl4+qmprAMBzUHJR40hwaOj7macvIGmwmaggRooDOh6oJVcQ/uc4zmMbT5lY
 eDTjJPMOjk/YxBYhL+TUWdUJ51CRaXW1/AKglEJuJVO8ruAR6Q3fkOqAlYtJSE2tZfEByButBW1
 2RTHPTGgPCkt0UJyMRwgKVh3Ygfm3QiIRssCU7oikzBHPnhZMztKVaWDr5daMe+ey8QKNaix80s
 GHdvt/IIDDXR+wK9p78T8sa1eoP8KlZZk3EQSTWGBT0nPEc9Vo4gqYqyvnXsu9oYdgHPpzdBD7z
 /csiwpTTu0d7mencLUk/O8aawKh8fjKY9jO50oFjQMVCLRBhIFmTgEACVrlqR1m4FOwgB0jd369
 5VOLvxFGuL/84825gRh1R0w6C2xj69ClEwYjQusPeJR89aCmZ5f/ziPhrO4JOAlBwNn7zWHqwSu
 XfexUpkr7SMISq1Cora56Vx9xnFrdOoq7vLEo2age4WZheIEYHxw2N/NdLI+j/+Pg2AGcKkX4+L
 ogjlXdyU3l9bfuhAomdOMCmOZvD9ZSt0DYrpEobI5hnLtBy0nmoxpzqlw6icKQcgCfoNVXhw5Tq
 kjQwqypVtnxryqQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'net.mptcp.available_schedulers' sysctl knob is there to list available
schedulers, not to modify this list.

There are then no reasons to give write access to it.

Nothing would have been written anyway, but no errors would have been
returned, which is unexpected.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 38d8121331d4a981d4a60ebd8f6cd9482fc2b50c..d9b57fab2a13e64b6c8585e821ed5212f59f8651 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -228,7 +228,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "available_schedulers",
 		.maxlen	= MPTCP_SCHED_BUF_MAX,
-		.mode = 0644,
+		.mode = 0444,
 		.proc_handler = proc_available_schedulers,
 	},
 	{

-- 
2.47.1

