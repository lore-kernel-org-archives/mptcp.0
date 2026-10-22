Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664781;
	b=fm/B32gXPqPJTbtms6ITLGtqP7g6BFBSkajyJlELrHChiy6su2waDKsNbw4fC422wEzH
	 kRsei9NHild1k5XxJckkfdOTtHht2gdTcHV3tjZZCw/hQqoT1USwoVXMkFlIcvbQGL29w
	 /GJkKa9aReTjS+Gyt53LCTHLLIJ5FYCrGhxqWD9gSOBKemQYdHVtjzp2Yex32AaiWnEcu
	 rO+0gPRPcjQXKPOikCJKhZ1JKHTrkihiGtuZql/kYTpoYY0jctyLNH+C+n9nBtjMyksiF
	 PU+9dGPaexQb3HE/7uP3eg1m+lqVIrX195iy2Rt3fAfzm+DXOPD4bH7FrEo+ui74wTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=XFwtI0GxSkcHzeJhZjcXfL7Gll0vLgeVV9xGAZi9bRA=;
	b=1SK9Yv45nLtB4Au9KnNcQq8WvA4ABjQIyJT9fEWH/hruEsvLVlXTB+vDjZ94586fnCRs
	 IilYSpkSkMKwY4DvbqUjADf4HINatoiH38o+cefkgNIAras79awm08wsSP1YQ7sQ8W8LC
	 YWF4zTsfCQESLUX5gfKtVELrl1h0Oi3BUBSgfQ3pUFsLYKxyR5YRYduMAh+PiOxqup4FH
	 nK1MgyKsS2bML4Sz+R8987Js71307d9hAQB7QHo1iwxY8DgPxjEjoRyj4OllwhQ/MPCK2
	 yDUWKewewYg83/toYYP2KsEmfrflRyO1WhEEaNRKc0pL/1V0z3MlZRdexlrzcKheq7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EncJBXNw;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182A606A31E
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 10:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3182A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EncJBXNw
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e515769d3so147262585a.3
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664780; x=1793269580; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFwtI0GxSkcHzeJhZjcXfL7Gll0vLgeVV9xGAZi9bRA=;
        b=EncJBXNwDg4moS93yo5NZMvnYblOzCGF2RdeYih5s6vTRW5gJNvNWecLsVBKtOu1Ki
         iIXz+u5eaH1//jaDR+pwP+Z3brroOrPUMGGsRUw22ZgkPqlKhcufXfKqbDHNjfEOwGpA
         tQom6zk06oI4ZjoZ4YWmkOAKjbNVk2j0Wpm0Asdh2qulM5Cy/zC5wBFrqrVSGyEILAI7
         JU2bv8rh6OwAxZfnd2TIfN102u721aGg7JcXXEbJmgxVj+klbPyA+fRdnA3ooIKHlXpf
         7JNMXftwvHxBmomk0qwurnKjrvlfOQJmAKy355JookXjDTsqpkRxx5FUS4W0qkesjICn
         Bpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664780; x=1793269580;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFwtI0GxSkcHzeJhZjcXfL7Gll0vLgeVV9xGAZi9bRA=;
        b=UeSfYV/gx69IUl0wAgMVbbRSQxjo94wBSrHb2k0ooGepz4v4PyIRrCVsr6zhaJ/dBo
         qKr1TdKe1zQTa0zhg98+OPmpKi/Oycn2C+X+vTvMBknFevi0Q47ku+2ELKWX8VwisHBT
         DzvpvotG+UY/haKw8ThxJX8VPGWhxZWrxMEGEcvXT27AdVYIL6XvxXe7gmQOfJg+TfK3
         TF3hO9TEtwTOjfc9PkhQ/zOLebrEuup2sqK5lvNadG2AVWUi2IUtcbJ5VlEWCHM35eIO
         5UdXeSWfa8HZvcQ7ACvRZWHzC1tEVGrEBaAUtrZJmn+5BePc8yymlxlK9LpyvW9juqtc
         vjkw==
X-Gm-Message-State: AFq9FYKoX4JJSpeo114GxDwzfkiH6W2T+ANSFJ/pHx9EDCjWZHvXQ3kn
	OowJ6gIQ0aOlmUjJKaD1VlnI0ZPNkpZA7I45JOSvEje+C0x+3MU30KY=
X-Gm-Gg: AYBFou2njtYaxpVE9DKmILA5cExH1Y4tPTHy2l53rvVfsEIOZ0Z7ny4555SUTcbOEbf
	2HgwwF/o8ttKj0h++Rbywhgni8mMntG/nllfKD/7FqnBKLTjE5EoitwHSnGDMGlRdPZUwb0X1xk
	2d75uV8labrX4cpyrlffL0jfFQJYc/MLUKKAJw2BQ8TdvoOS+M0PnHFCosF4ikUeK7Yv6rPUEuQ
	N+H2GtY2ftNCQFH0B91P+nvPhzKODzczuuhVHL+XWITYf3iqQS1/t3Qmjasy2OqtxX8h8cuK8fK
	YgOMMjg42+o5GzPLRIbxAW+Mcvk3LzY2+j5uIj7MOW20wTiwndchoHoSYOglh5dxApqqyCGYs+i
	3oFMERb9Hg8kG/05HoNJKMAe2NClFTgyWYb5tcrhmJMchrZDR9rRr8LLauT3C6xVaMAX0t+1U/I
	+zk2bBNZmoVHUspXzhtV2JpJ7v3+YG6qUhKeHVzotaq04WdpErp4TtPYonxBLbU6x5U9FoGsFM+
	DJGDVR1l0OdW23mRFVKn/6QWFC3t19f95DRoAmFbXIH8nqbQACYg/ApVe5ybQv2FLdLXiWz596I
	sTHzsl7+HFDR/ny7
X-Received: by 2002:a05:620a:2b83:b0:93e:9508:8360 with SMTP id af79cd13be357-93f57f062e3mr910389885a.27.1792664780098;
        Thu, 22 Oct 2026 03:26:20 -0700 (PDT)
Received: from github.com ([172.190.126.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e30610sm476215185a.43.2026.10.22.03.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:26:19 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org>
References:
 <20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: kernel: c-flag: mark as used only
 when it is
Message-ID: <80f98593-079c-cb2b-8f3a-bba2d191e522@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 10:26:19 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/39756392967

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d52f446778=
4e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1191156


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
