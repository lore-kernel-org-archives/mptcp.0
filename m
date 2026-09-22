Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8554A7C6
	for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083820; cv=none; b=YmD4DklIhg8oj/zggYd81CiPzFFbSRBj1Z1KRqWJfk7I2u8mfFinnd9HwoptGlEdaG5UKtwHxtvFmx6dnqI+zN/vEOWtd2LCv3Q12x5mAsjcLV748L5qnBihEHATO7RpGsj8irtw9tiYrmj8XHfNmsUfhI5VK0WIqkRaOuMoIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083820; c=relaxed/simple;
	bh=Ovh+3NCfWArkDpk02CBsC6ZVrby6mZuDUCj0rpEsB8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ic26kJ+uoSPify8G3CEn1rwY2+XXDCsZA+V8PtFBkfX/cecDT3/3itbglTEWiZS4D+wTL1r76Im62ghbVJqRMVj6AKazS8UFGx7Pd4Z9GHyJbsGh9hparg65x8tYuVuKJBIxtAnkKx0atsmmSThBNDeqzEH0TCLKJtXwTfLD+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGYgc9hm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGYgc9hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790083817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9g6BjyVGZFd66XuNlSGdvaV1BKMkquG3R7mnAoguds=;
	b=BGYgc9hm8i6Cg4j/IJQS/9GSTmWrVhmeNQP3kFYOzZ1FdAqOFjsskvHeN9zQo3CWziFqiH
	c0a1aXnpBvaMJX5ARgDf4zBXGb/JWEIFmodQysRBXe0lFa0SLefZ6Vcrsw0Lqg+p/HrLAm
	XahMELlCw8aU3msOz/h/XhPGW/34gYQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568--AgmiWDqMDGSUJ1Aocdscg-1; Tue, 22 Sep 2026 09:30:15 -0400
X-MC-Unique: -AgmiWDqMDGSUJ1Aocdscg-1
X-Mimecast-MFC-AGG-ID: -AgmiWDqMDGSUJ1Aocdscg_1790083813
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c25edb54d22so500538366b.1
        for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 06:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083813; x=1790688613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9g6BjyVGZFd66XuNlSGdvaV1BKMkquG3R7mnAoguds=;
        b=EAy3B38oKAjKGrX0iqjxLLZPggR17CNQx0pQz1UQArVhWzM1kE1xW2LljY2vcz2cqg
         faoYyMWCDsYdJOz+C4cTUg8VrecXwl1N+0blE7gM2p7Sy5FmT6q+RPspsz77kyHxRkL4
         Vr/MGGFNOA7I8T4D66vkg00CTscwJB1xtzUemuY+Zc1MD7l1scRmTUykCt94WncuHysF
         go3IwJHKi48aMSNRyuxQSCkYueSLmdhdkRth26BE/NWwaOUpIoAzNRAx/qed4f0DrmOO
         tt75m2WOz7s+CMx8HfXYY9blBTGo8pn6ZPMciBkhOm6QD2xitVixvbUGOC3Q9xnrYs1f
         ktAw==
X-Forwarded-Encrypted: i=1; AKwUvBzkSt1BgNVTDdJXWFzIeUfkE1gLnO5oJLglf4JcGTfCoXobUSt1vyMnue2jMK1sy9mPcua3uw==@lists.linux.dev
X-Gm-Message-State: AFuF++ldfz281qwV1rounqcAszEGvuy2s6RhoJ1sKG7Rd85SYUfqj9xn
	/z5IN89r7EToygo3mHtZ3CRjPDV3Lj8BeLdGtA4FzwXprAGhiuv5UPTmnZQd1xGMnFTq4o5eUaS
	Gt45w24SkCMnqOKw7fVIENFj/BJRU4UgI+jbIkk9ZwrLPcxhPDYr7P12K
X-Gm-Gg: AYBFou0dtpoZ4xBtM2/ppZkse+jOYS3bXtILGDfHnSmeSh+H++kFjlNxgoqPk8nSDOJ
	F3EovjsCLmjRvASUAr6XOUoos/txhPlYuG7nuMb3URtAE9nt5w2Y40U95YBkT/mo7dttRK5q3/x
	d85Cs5tIetVOFLsg729crTNOTQxsKo5dHmGb71r7W8rRLYTKpFpTgEr+NMPFK0Gk//d1iC+YOx2
	+CUHFy0AUsn9tkGEjMHB5IqknarBbQ+NVWLrhRfu8kZPsucx251WDAME6Z6SJyPdj2F732EUH8I
	5G5sVXcHrQ313cCm53FQY1rD2TnuwCet94AsC5MYh+jlqHWTQN6AMrWWs8l2NgXdc11d68zB8Ws
	dEfB7pojUIG3bPQg3J54+TkUkxtifV7kc4tLJRzx44AcIWl00xiOkeN63Wis=
X-Received: by 2002:a17:907:72d3:b0:c29:f5d8:9c70 with SMTP id a640c23a62f3a-c2a158019c7mr1066564166b.31.1790083813098;
        Tue, 22 Sep 2026 06:30:13 -0700 (PDT)
X-Received: by 2002:a17:907:72d3:b0:c29:f5d8:9c70 with SMTP id a640c23a62f3a-c2a158019c7mr1066561866b.31.1790083812536;
        Tue, 22 Sep 2026 06:30:12 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5832fesm88079966b.30.2026.09.22.06.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:30:12 -0700 (PDT)
Message-ID: <d6cdbc83-86a6-4c2a-ad99-29cdb83566dd@redhat.com>
Date: Tue, 22 Sep 2026 15:30:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mptcp: support MSG_ERRQUEUE on the parent
 socket
To: netdev-bot+sashiko@kernel.org, matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 devnexen@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
 <179001595171.2160803.3670624686905872378@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179001595171.2160803.3670624686905872378@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LQfp3Ol-4lG7PivLLsxyBzVEbvHN6167sf2PhYf2g_E_1790083813
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/26 20:39, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new error-queue splice is dead code for MPTCP-native data:
>    its only accepted input (SO_EE_ORIGIN_TIMESTAMPING skbs on a subflow…
> - [Medium] Forwarded TX timestamps expose per-subflow identifiers instead
>    of parent-socket byte-stream identifiers, breaking the…
Sashiko comments look relevant to me. Basically this work makes sense
if proper support for mptcp-level tx timestamping is enabled and the
and sk_tskey is resolved at the msk level.

I underlook at the above during reviews on the mptcp ML.

IDK if someone is currently working on the missing work/bits.

/P

