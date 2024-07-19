Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A683CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391876; cv=none; b=ClfsBogbrISpfI+MvXm9qnSEbExmx/hZREOYW5SMUlLu03vEXR2HT0saJ4WfsOqxpQFk7Qvy6WRKPjVS0J81H/gP7PyP92lttyWzGySohv+kVgdqq/trJABi0f5OUDpO+ozlo/IXOvFaLbVlVZwFcvQWYoOcFrH2THhOL67tsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391876; c=relaxed/simple;
	bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptyWWfIuKjxYZ0scD4NZmteTKFxVxAJGY1oH3dCuvoaa5X3nA2NOquH3QU96q+YXQi/X/+8yEANfYyhpmLCtgHOF6rx51A7Ei1MGez18SovvxbOygGAQRWzdksu5YKwp8ZrR8CiakiRc4gbN7G/KjvX+Mxgxr59zjm9BU5a5tIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXJdROZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXJdROZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568CEC4AF09;
	Fri, 19 Jul 2024 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391876;
	bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VXJdROZNrkGpG9qcpNlquE6Ei2cbkP69MW6OcSqrn5wNF1Uxx+ydtOQ3cBZtiZzOL
	 QJCMas88flCjPd0Rumdv5ofwUAIYXxxhf0JZTHOTPlsVo9dTVIDxxaTecCTezwvhfP
	 3ADyNfr455/ASM0Qc0fdZ2qsywYneD6859mJObOo6IdSuWfQ+EBtUVkkbunfnXn6PF
	 KB3qfVRb3KUYMaXjZZJmk4/ELh8uHekfs1u3J9xFUnciIfu46X0b0E7Lq0gsCRJiXn
	 Paae+8dBuj1T7HXLBlHxT7ThzNA/oxAtv0YCovfaS6/1UipaNTwR/uK6sgMyHxNRJf
	 X0ZbhNOG/LP5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:13 +0200
Subject: [PATCH mptcp-net v3 02/20] mptcp: pm: deny endp with signal +
 subflow + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-2-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/x6RqjWS3G5qyCir1+EatO690YSKHtk2TE
 Qy2b1umLdSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c80bD/sEFNUdjJ7M4l5zvcDjAYu8wox3QHqM5oHb5B7f9Wj1NsuI6u0JgOZtYLPQ1Sb7UYYUefr
 Xxx6oH/JNfH43ss90KeWQUSrawphDSX+UT9yI1mcvuAubBpNiYnecgnBoh5DO8CEQAkJqyuKr/U
 sugGJY5dtIBoufInQ/3NrN0MA62lZnzo1s5+gSSRYP3vJsBh9wepYRsAWOrut0joC5BWcg0r1Xq
 YsiVQeoxMoZEhWwP6vDTx8GajUN0yxYTyL9UPjRMKgxZ1Y3YngSSE4A5n234URW+B4d1ijNzeRJ
 kwj67PXOy8HQGWxuczdSI1HF744gumkAb5Nkms9clomM88Y5OBvdK+iIomXxAu3/lSym4s+UYs1
 ++j9qlmHMVDSdEbZjxbIfyWE6QdNRsCurs/WTZdD6PggUCtzjYAeXohw97r6wjwHuUJtJvjgXL7
 92KocBWhNUBQJzngdasGm+rTG3YKpISIYjICTNEwqIxe+wwrwb0p6AHc7fp/5uovs2OJp8V7LiJ
 kDauX2IDqo/tKF35ndLiWA+RMuTJVmbYEcqRIVuHuCHIYncEYRRU1G67Iav5JFLO4+Fink7vqVJ
 J8VEariOhbM50n4IDcNUZs9FR1EHhCAt17ndFm1yW5tvFpVv/BEZrl6DHK4JnX5v7k2BGROzfma
 2BGQK9F/rFxNulA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in the 'Fixes' commit, the port flag is only supported by
the 'signal' flag, and not by the 'subflow' one. Then if both the
'signal' and 'subflow' flags are set, the problem is the same: the
feature cannot work with the 'subflow' flag.

Technically, if both the 'signal' and 'subflow' flags are set, it will
be possible to create the listening socket, but not to establish a
subflow using this source port. So better to explicitly deny it, not to
create some confusions because the expected behaviour is not possible.

Fixes: 09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..c44b0ae51cdf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1311,8 +1311,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+	if (addr.addr.port && !address_use_port(&addr)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 

-- 
2.45.2

