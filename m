Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C679F3
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046810; cv=none; b=WJt01LZHXYlVClvm0nvLZ01yYKU4Ovp4g3+OWERB9v32AOTko69aYbR/byxAeUOA3o/DF66begEWXIxk2alLYvtxHh+6X/xtRt+XL8TVczA4b28sQ7YlZbz2fZhDxEoS3tE0iU0a3p9t8Y47KuWJOK2xG95bmrde34YkOifHLpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046810; c=relaxed/simple;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8MvkSTTYXlHAVSVzlPKEvGVJhY5vzGX4Hi5Y5QDfiykO137CRc0a3gIC3Z5Y76J/vbnGr2CjhTtLmbuzMSQPbvLyquJHeCIHwWJYZKA9EkT8i2wIR0F79GEu5Epp5DklFy+uc8ul7/+LpNp9pkOARLTsWRCQkZLR3YUKSRCmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvhJva69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvhJva69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28073C4CEC6;
	Fri,  4 Oct 2024 13:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046810;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvhJva69VoLQ9QF91/LSAIPWrm+UL067AL0FDVv8tsUdaOpagDmAkuEH8MQkOxOkZ
	 6Fs9FCMK690fTjPHTyG/kdqkL72ePvE+/Te0SFxY2yKVl53/Q20vABilKUztnJHHS0
	 oou7Wbn3cagkq57nHY80S7kNuxMOppir0X9YdMe9yMx3sxuDWYxU1aExrC3Rr7sAi6
	 GlKgqia+Ir3z/3/eV6KYlh3E7WpGIWoLctW4F575sLiMA/GaUgtgQh8k72L8TYRaz0
	 01+VbQo/RYUpe0JWUfcSd06OOMXsaWOHzVgqq/V2OWHt1sAb0SdpsimLFVWn1HzeLu
	 qQpe25DyPTP2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 9/9] mptcp: drop subflow contexts in mptcp_sched_data
Date: Fri,  4 Oct 2024 20:59:49 +0800
Message-ID: <c03d970f4be3886040d6154525da94654a148b16.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow bpf_iter is added now, it's better to use the helper
bpf_for_each(mptcp_subflow) to traverse all subflows on the conn_list of
an MPTCP socket and then call kfunc to modify the fields of each subflow
in the WIP MPTCP BPF packet scheduler examples, instead of converting them
to a fixed array. With this helper, we can get rid of this subflow array
"contexts" and the size of it "subflows" in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..84d67947a517 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -104,8 +104,6 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

