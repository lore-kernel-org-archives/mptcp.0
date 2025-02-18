Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D523C385
	for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877896; cv=none; b=hksSmmYx3+3eCcEdnf2VOsnHd1+JnKWi+rw8OVlatGF8TFEkBcF4HuPK05J1FjHnVPzEEIc/Vz+0Oj1f8caN+G6IqzOsxHoMGVgw7VLlqlkOLtT50wxtQlLtdROiIKGhDN2w9PHrT8QzEcL5Yb/2mMzEopGSQs8SKQeUnKrQCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877896; c=relaxed/simple;
	bh=jTQZdhnD4SDNeCdoABo6+2QrCmcs9b2jVmYynAo2Rew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxQtrBBQVo6BfAbFvrYMqbgFeqrXXV1N7ycQAqqjYFt7u1qnKinFqK1lR4k0R7QimQQJ3fNW5ZF/2zIk4t97LaF/nWXNYQUDQRacLjPauBotovddYgPxdiEGcJFsPFHYfzU5b9QW+SAABBXDe+T/t2vBqRssjwomsakyjMf46NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POAFnaPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POAFnaPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71072C4CEE9;
	Tue, 18 Feb 2025 11:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739877896;
	bh=jTQZdhnD4SDNeCdoABo6+2QrCmcs9b2jVmYynAo2Rew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=POAFnaPmR7c9b7lVDfJMNdSpiZhoStUJL7pppL/JUiI64ln+lvDqWldsNkSDa5Gmg
	 kWNR3fvy9mQXtGyFHogE4nqPFEmMxUIp/Bad8xlyXxe5NCO5HQZgeEIFsswJ9CdFyL
	 J1cS5rub6g1gLxArYdAafdhlb9JKVDZhK3Hf77/IZUPM6wf6AQvNV+qqwfzsy8U0mP
	 q//70Lrc4TrW15JgfBXViThKJbzTSyB/ZS1SjjxrxPqYyY9lSgxMHB3evglLP4ndZO
	 Os0yO+vK/1YtjjU7yjc0ysg5231EaXT61mVlkgk00Uk/zbP68gSJa2cexAAh7wWKlf
	 lnprL8aiGdcyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Feb 2025 12:24:47 +0100
Subject: [PATCH mptcp-net v2 2/2] mptcp: safety check before fallback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-mptcp-dss-drop-mpj-v2-2-0c6caa10ec52@kernel.org>
References: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
In-Reply-To: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jTQZdhnD4SDNeCdoABo6+2QrCmcs9b2jVmYynAo2Rew=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntG4ECHO0AaBZ4Jrq4J1Ygp/RkiwCVzSD0E0qt
 jEG67CIEMmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7RuBAAKCRD2t4JPQmmg
 c162D/0Q5m2Qbp7knOJdRvobQGJ/rAUj2p3nRvnpNSpo+5greiGf9ZpVKiQzKu9SusOJbltQJhf
 UgvbsR4irNVAmgoZ+LPFGAhgjea84PFOxcUWsimGd63u9g7GLw76fkf1HS1H5ochgba8yLyo0nz
 X8Q1+UJTMMTwAToDVZRfxObjoNbHLsKZHMwtKYXtBg4vJbLWRhqGf2ZjEKBbobP1HpART+rWKOc
 u4HiL8kQNQkzdjNnND5vf1K4dByr0aKOyvqZf/AWAfffOm0OV0unuMicnV/2Eh9Pa8DId05XpHE
 nkCk/BET40vTartApv+mzMHg/wvdGH4LiVIJUrHyVsCLQJx79P+lD1dk1egwBOTSGMqYjm/N8x+
 o6TW/LEtVKpMsSGNB2gw0OEvamAapAlYRsPaZfnCdtZiCOBQm+oSsqFbWWF1bHtVdsTwTA/hIXA
 QmFryfd6PdR0sl+jR6RMCoDq9sVMQBzWrYIC7YtynwC2d+phkp86gpWrMK2eXHerGuKYD7iY0rh
 uuGdJENZdGlt/Tf1GTwmUBZjgzQxdDlb9kAiEuqRss5zNLrf9YrHfVt0gak/ofvj56b1T2sdt18
 mbKsgweAgVWCislT9jrKcGwVwrl3gdvO1BumQ5utpnhZwXYlbqX2bxvJitco3Dfq3O5YdX13Cqw
 WdwcC5a+U6sy+ag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, some fallback have been initiated, while the connection was
not supposed to fallback.

Add a safety check with a warning to detect when an wrong attempt to
fallback is being done. This should help detecting any future issues
quicker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - I guess this patch could be sent to -net as well.
 - We could also squash this in one of the previous commit, but because
   the two are needed to avoid the warning, maybe better with a
   dedicated commit?
---
 net/mptcp/protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bac5c925a72f6637e33ada9869984c5902bd6a43..3d72ca1553227cb41ba8c205f42d1f01cc264a7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1198,6 +1198,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 

-- 
2.47.1

