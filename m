Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1526E6FA
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383176; cv=none; b=XAMXPFShxPpg1YcHr7qvA8E235wLgCsoB2QikJ6a/RiIULaVq9DQoN/l+4yxg9rV/CNg4LYOPkQHGcRNsmma0E+lZCIrZiaUE1AAjZC6NmgbV5u8PKF4Y53CRxY4uTbx3NVQCx9IHamYKyxAXaki35TSedldKvNcPsLaspqmWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383176; c=relaxed/simple;
	bh=zONq4SLl7YtrTsbVIG2l8toNftm9YhFiXYyWdz08LuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByjVxOSPcDA8kU0KD1VIsUruPHrO1SmafTKHhY1HJo+U2vBGNb7TVrmQxNqVVS9Fz5q5Lwz6vh68q16+tv0dUz8qzOQjMDLAq3uiGnwERLkHmfM/JY5dSLPd4B6J7E2yoJehJYwTsW1+cJDtqv+pcf02xQcWFP334uf0ogYewzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e2EVnnUU; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e2EVnnUU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773383170; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=MgnKRdF/WGWoCzWrtBOY7ja4YW4ranVaD8FHhM0omBo=;
	b=e2EVnnUUwBadzjTGBNseflNo/0AA1Tu1h9aPqzZJDx7MQdWAg/vd1ceLo9SvuoO9mGd+BXEp4qEeSXvIpKjspdtaofzyjqPxdQlNJUsEgwFaA6cZGf0dfLYJcfqzdiBYSHRTn+7LD+O+n+dWcK0iK8OfIIxhx5QYvwRrDZ1Oj1A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X-rCbJy_1773383169;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X-rCbJy_1773383169 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Mar 2026 14:26:10 +0800
Date: Fri, 13 Mar 2026 14:26:09 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Subject: Re: [RFC mptcp-next v9 09/10] selftests: mptcp: connect: set smc
 instead of tls
Message-ID: <abOuAUaS1Rjutn-D@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
 <d146e42dfe374cf28164726f6afd4b0b0ee12b6e.1773365606.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d146e42dfe374cf28164726f6afd4b0b0ee12b6e.1773365606.git.tanggeliang@kylinos.cn>

On 2026-03-13 09:42:51, Geliang Tang wrote:
>From: Geliang Tang <tanggeliang@kylinos.cn>

Hi Geliang,

Thanks for the effort !
But it's a pitty that SMC ULP support was removed in
df31a6b0a305(Revert "net/smc: Introduce TCP ULP support") due to
it violates some VFS assuptions :(

Best regards,
Dust

>
>With KTLS being implemented, "tls" should no longer be used in
>sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
>name, "smc", is set instead in this patch.
>
>Cc: Dust Li <dust.li@linux.alibaba.com>
>Co-developed-by: Gang Yan <yangang@kylinos.cn>
>Signed-off-by: Gang Yan <yangang@kylinos.cn>
>Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>---
> tools/testing/selftests/net/mptcp/config          | 1 +
> tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
>index 59051ee2a986..18bd29ac5b24 100644
>--- a/tools/testing/selftests/net/mptcp/config
>+++ b/tools/testing/selftests/net/mptcp/config
>@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
> CONFIG_NFT_TPROXY=m
> CONFIG_SYN_COOKIES=y
> CONFIG_VETH=y
>+CONFIG_TLS=y
>diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>index cbe573c4ab3a..64c8a4bfe749 100644
>--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>@@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
> 		if (ret == 0)
> 			X("setsockopt");
> 	} else if (proto == IPPROTO_MPTCP) {
>-		ret = do_ulp_so(sock, "tls");
>+		ret = do_ulp_so(sock, "smc");
> 		if (ret != -1)
> 			X("setsockopt");
> 	}
>-- 
>2.53.0
