Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AAD1F5EA
	for <mptcp@lists.linux.dev>; Wed,  2 Apr 2025 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562398; cv=none; b=IGNSH4ksKuYOijsMmDH67Ui7bdYnxgkK9iH1Mbg2K0mQQRNWRJF16Y2mTkW8Wpar1LFuJXIUDmwlB8WznFp4Ydj4Ol2PcXYR45NvPzshGJELlY7MMBLOMD7TcK2aqQnbwJ5QMLRNWAgj831iLI5N5rCOMiU0xkcHL22x1B4PYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562398; c=relaxed/simple;
	bh=ixbxNcyIEzcBesSmeq4VBPB/qbiTpd1kzfZOphjwPsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KN1qvANPHwJGJvUfknb7IvVQaT6XMf9nUB2nUQuyC5Fk415FE0B2vxc3ePjeYTNMz9s5jtA3LvbeLFjv8TQ+fa3+a0iLzCcCqL7VKrushYXI8K7rDiM+5q4qDfpytZjpuimZnOywQC+OCQYWm5swXwiD4zi5LAs5+AMe5p+ZssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYBZyNT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYBZyNT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32981C4CEE8;
	Wed,  2 Apr 2025 02:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743562396;
	bh=ixbxNcyIEzcBesSmeq4VBPB/qbiTpd1kzfZOphjwPsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYBZyNT3W0Sp/wxkXr0hoNQ+g+8BZfU9QQjjvvUU+wr8lruTM6GzZJngpTuVg2nQf
	 P/FUjdnyuonW/B0eaaLDGniwAr+Df1cXzBJmSRHC3xPjugwaXb0xRfFwXb97wAQMOV
	 9mONrm6W7GrJz3/FD3kNp254ezLOErqMHT6tuuT3m72UMTsclshRml/mRBlomQiRgI
	 cbWikYNOOAfhW6zgSHV6WWJNxhojJu8jEOKlBQNeskXEPL0Dm8ozvm+tNXZXTTzRCY
	 c1epCtKYKJo+9/wcgCM5QeXXAN5my2+cfesPyxfWT7t4AdR4sQwydBxkmCm6hJUp2N
	 s+XmJrM/QOKAg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/3] mptcp: pm: userspace: local_addr_used-- after sending REMOVE_ADDR
Date: Wed,  2 Apr 2025 10:53:07 +0800
Message-ID: <4f0b16c622b2714069acf8607de0d4e7f0c013ea.1743562290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743562290.git.tanggeliang@kylinos.cn>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address entries are removed from local_addr_list when sending a REMOVE_ADDR
by the userspace PM, the local_addr_used counter of PM should also be
decremented accordingly.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7fc19b844384..db471eb836b3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -331,6 +331,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	list_del_rcu(&match->list);
+	msk->pm.local_addr_used--;
 	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addr_entry(msk, match);
-- 
2.43.0

