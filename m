Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856285;
	b=e5//fT82nyob1LZUVdWAMNZR64hmjzqiYdFkf8fR7HYylIQIRLa4fH/QC1JPkhRYKNAO
	 uM/qkM5lUYzgfRhway87KrOVVHiDyVo+gatdbb6MaeBLoVs1Y44yt43AbDA7TbIHAmlMT
	 YXUZEYmEmcZwBHZEMHb+S/pVf+kanLvBqDT22ISS4TFv7QVRLrU8t4C3u3nfE1/HMEtqT
	 WF+s2cd313u6ej2KPOvgBnVtdvsA8FUFV8oXE4wXI7XfmpTVDXe2wYUy8eHiT+RaQcnEx
	 tJjNRG152n6MzXevG45n8VXabtvI197ZCL8WCyjvMdhWuJRaZu9mKjcL8JyFXzhJhxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=79qCboJzLt5wQdEwqz0nZbLiF7vowhHYpHzADqPI/mM=;
	b=3xEMQ1hQZwR/cQe9BYzTgWeBw5zzP4yhyj1nZ9YbZe8m/KXQF2qYc5miHLp5vHMkRT8J
	 kPCrgkApF4Ov5xqumc5iU6T9LXIZR/afG3W3yAg3Q8AA4i/k+UEmvLwP259eqWZHHP5zp
	 JmJtNuZJ/eaej6MGx3l3GaDLVx/armIXv8eq8H2LOhLkb2Nbm8wDCEZS1npXRY/q21oqA
	 /TwaR9wV51cDrBqjVa8sKz9lnhwj0RaEo4tN76+JR2Rsb+XvcDCWclQIEI9ILAI5IGtyt
	 cx16k9CXEGqeovT4EwpXx0KHgj7nSckh4ITzI/F9TL1AYE8pUmaM25pe8yH871k+B8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6dNi1mq;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BD606A329
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 19:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 370BD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6dNi1mq
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b10d24345dso35190377b3.3
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794856284; x=1795461084; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=79qCboJzLt5wQdEwqz0nZbLiF7vowhHYpHzADqPI/mM=;
        b=F6dNi1mqf3OzjMV3+XaN1rJECT4MApszpVHGEeSVyzQ2vsLPPHllw6X4XyQzn88VWz
         Y4Y3kBiEWgOCb76T3MP1mBSsqYoSXMyOQwBEYiZQcTI7N4nQL4cPjsnHHbzizV+SwYv5
         Io+lzZUKAk99JGxNQnMjYlGKsFwhEfYPNw36BGKNo6SlYZyiBmQsosrZbymjbIc3jiYj
         tGuFwchWiggJHNGCNcfOUeVt3gpyRCIGxtW7YtxgHQnmcRMRejBuyczZdfqbcwZXpjpi
         cbIn065koLjvwXChxgizBRgd/+gmqgNZgHw26uF7J4e9T4X259GrxNUKS8zHWZzX5rlb
         +VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856284; x=1795461084;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79qCboJzLt5wQdEwqz0nZbLiF7vowhHYpHzADqPI/mM=;
        b=2cX4AGkOnPpEEN6ORQ1Nmo28TQw0ZEct5ap0AZk4iSUxz34RniR8fTWJ6ZdppVSnCK
         MIJ3fnO3FqY0JIbT8+GdPE4oBxUsh6A3bjyY4CW+JV3v8lvkgDgG18mTLXE8G+JDf+3A
         jZUYYBWb4nio2PEoqjZHEIWBnSVqFAJhLSoFcLETeo+flubIZ4YNxCoxU+uHo/Fqq6r5
         +ktG7SrnnZpBv+fgTqcOZJIJTbnOwCMSKJQOmvjpO37w7vQZ240STBAA95+xf8muerzS
         hQFPzAyEtZgVyZA5eKhD8WwW3+lxmDy4Q5vcdUsFZBrsVbdLW+gy0h6s/tVAODoJa0f+
         95mw==
X-Gm-Message-State: APuU4Z94YGnA5phucFgKG1hdWgOcROhm8yHFv8XRNx9vac5vD6iOkEJ5
	siaauW2GkdE7ptEZncytJBcaKRVL4mTshqDqN0SCbbZkquDToYS7WhU=
X-Gm-Gg: AZFdTZf2LSKsx5uL5/1lUI3CjOto3AxvsIg0+2jdL3cRIxdeBHydHXfBr777KpE+bw0
	MsKBXelu5CDLROGbmVWp2ldkkAZxz56DAeUcdOnuZaeYa/hhLb324LVL+UqvNMfFMNjL4YvhF+N
	3bK6JoGva7TmPK9BaFNhsAx48UqZOar3EQpW6QgMAWNiwk9K2mRYwmZTkg/YrsNSPYkfzAXFbx2
	dogzmHR/uoBlxkWpqmaRrddfLyW7GF5J9biInlBUTwl5an7yzpO6n+cAaqGBTtGRyltxg8UcjK8
	jCJGONKLslcq12FLvubKIsfo0rGtlR/CniG+kZ3Go6OkNRjbQsvDbmXXGPDjn3mmgP2p8c1PCeP
	jWDIoHeOY2ci5C8vdrRhsSIvYqJCJxj9/Ew0/04n41FcyCVN0A0sGwAEJ3yaCDLyGwRLRX4ixPp
	rZ7iDoGohvjyKw5EOAAOczMgd9AD7gUmzH9Y+v8G68TqrXwLb1urfhEVisjgz3Q3WGwZE8jYt/r
	gMbtCycd4NpnpFRhVnPkXpwJYq3HJhnu750AQz+FTOGGjKqVZf4zOG2WbGVJ8PWr2RQeQUq2HxX
	BJ1mTNLEBp80NtNAcJ8zDy46BG+zBapDBHXQAhFlhA==
X-Received: by 2002:a05:690c:d8c:b0:8b2:e86a:8f0f with SMTP id 00721157ae682-8b4aa2e4bc7mr71908487b3.28.1794856283940;
        Mon, 16 Nov 2026 11:11:23 -0800 (PST)
Received: from github.com ([134.138.33.19])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec302a6bsm6283157b3.42.2026.11.16.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:11:23 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794847474.git.x-professor@outlook.com>
References: <cover.1794847474.git.x-professor@outlook.com>
Subject: Re: [PATCH net-next v3 0/3] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Message-ID: <e7f956d3-c673-ab16-64ec-a730fd1524c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:11:22 +0000
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

Hi Yingjie,

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
et-next/actions/runs/43915933839

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b0e56604f8=
37
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1213013


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
