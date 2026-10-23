Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725109;
	b=X7mvmfrV6cmKz8ytrg3X+5tFy9KXjHbkVkni7k8PsepX+33Bl8wwppAQwJklRuL2FGZZ
	 nXFmYhJ42GaBou9hxDHOyKwUfKHe7Y3Hz/+hhxsI2ZbWwRvicuMkL6VRJCk8U1/i/mleU
	 j/pl7Aqk2hBiTg0iGHVmxmUXr7uo25Ev+PFYfJhhrGCYr8OklXPiedOdenKl+4d6PCNv4
	 yR2r+1nsg4fvKGinDvkvvklFKnx1vermP17UDZ3g1zLYWO6A7hR09gQTaHoUEhoqaGAwT
	 IZZ+jchVT0gy2FJ1TR/a+1WOl4sD8sDhJyYV/n83dzKYdywDWwdV0a80EYGulWWcRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=6yUtFgc+PA1cU7QiLjrEfVOvpCqEjIZ4LDCCVX7vmLY=;
	b=Usd2h8dRDrbamKxD4UB6Uaj0gCYUJRLa2K+NWCotvJIhGyvsaaQ2KS5drNerRQO5L8bz
	 ZaJiByGzSYOK2spHgdl28j4RkhYMGe0J4EexFD6MsBZ3U5o8pu2pQjLIpvPbZGxf+ymj9
	 K2urYbS2BDdahdpqSW0vnRj6DsPNQr+hssiXsQhfneLL63lJSiT9ZEYUEj2cc95iOr+1z
	 sJ/JMHoebY6CZSDfbjm5TQfne1m+ZEirbySEPi0YPPa8EcCAFu+VGZTCfmb16YGtCKF/1
	 DmhlZ/ztCz5Vp5ynUSkrh4Ryx5IRcRg30+JBxmwpBwzOZeRCE5LrJxKygudI77fB43g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nrV1TAuo;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EC606A319
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 03:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 634EC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nrV1TAuo
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-535f9de49fcso2380771cf.0
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792725108; x=1793329908; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6yUtFgc+PA1cU7QiLjrEfVOvpCqEjIZ4LDCCVX7vmLY=;
        b=nrV1TAuouTgjmaCerCwR4K8edfdhaaeDXWN5Ne24UM+dY7SgSF9+hbBiVNwqw0ytpb
         f7d2kR83Fp1ZlT9JJ5aWF6qUlud+osqdPbTsIox1U9I9ZjAAy9fmWDsPsUX+GpQQkHgd
         tw31+/ouXziHsStfYYXBFEry2GcIKbcWlVK7dMp5yLmMfufjC+fEWAaPpZC7xWAC5H9K
         qO9z+Xkod9GWQuemY2doktL7TrilYjTEfrJSqmw6kXMpVQ+6h7wPuL2xw/gOhwrfX0LR
         j0N6eY/ioMMSFJ3uW/ypcXdIfWJHNsZUTDaTDzYUjocsKOpY8GVx4kQUlBBZ0truc6SV
         r2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792725108; x=1793329908;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yUtFgc+PA1cU7QiLjrEfVOvpCqEjIZ4LDCCVX7vmLY=;
        b=YIPvpvQ/EVvdRXvpAnJouigqR0SJC9yLHIEyE/ONQlUQARQgGaEAZjgdzV19EJCw0L
         8XAwZoAQ6Wa29RvuMZdoJrXxIHAJGqobXSEQEfnCZTF6RIOWHXYbDXqGL3yDInOK+4rr
         Sv1L71Zu5kxSCST5rqi5s0f6Muy3fE8B+XcIgpqm3KHoQwjQ26oFu10VcSOe9VmPrdPb
         48UkoXXk9iwG5YmEqu38xzgDBiS3n56kn4Al1ebHbMXUYphlKkKnuL73aLnLbU8k/kxL
         WryKi/qJHcZQzoePGK4O5tAyJetI77byfeytwct6TQvlwm4zartETle4RSqtiMHJh1uM
         p/tQ==
X-Gm-Message-State: AFq9FYLT46kaez0tqvjJk+3CUXOd751bKzdR6+fowLxbHpngevVHkeA4
	FdUiFyLdhMfMBQTNcffJI4kLGMA9dydrtZ4Ann1vugKSmdQrsijfxsmeEI3M
X-Gm-Gg: AYBFou3fXGnqNsEHYc1gWbsS6JF5ZDyS/fXx14sd4ygCyCT+AWtI2Tq4w2dwRX+QPbO
	WDnAhjtVFqeYBg4MQindwN4J+1mQuSXQp+g1sAO9XawWBltJUzTtIpRItRBXEwB8tovH7yIs8iP
	z4C2EZ6Fg4oZh3PJsZLvrHvnKN8+haGnnZoS5Ypg2AbNHRfYjzGgmYmyI+TVvbGeoluOFMHPVcO
	Z+PYPNmGztkuDOwjmr1m9cBfyR4BnKLDJLzQZUF37lUrJ6Zrn0WqNpDiz2JZwHDNYimA7CHTNFc
	KYhliXDU4zP+tqgZxpEoJT/llBA1Lzmr65ya8H7Z1IQKIs/Kt6CKNMQNBjtHaQ1BbEkEwNn2XVG
	a3g9pVbb9TnCoS6nv1uyqQojhzJeG6zxSsEr2wBKbfpKUIkKbJHNk+Pz+qGLYhe7Q/N3b8zeLke
	9KtR7Z638o5u5YDNbp0W7rTxTXGHeputio+3tgKeGGIoBzPC3kZomFnJNO52J3Icg4iR5r4bV1Q
	4UJF4AqAe+/R5VlMztPeKrXu3NAFTD5QPnbJKV1lap6hUWTiEdJRKb/enQM9MYnbpUrF0jT7LUZ
	TRDXO+uB3O/oapja
X-Received: by 2002:a05:622a:4d4b:b0:536:5696:e8c8 with SMTP id d75a77b69052e-536c263f087mr12547341cf.28.1792725107945;
        Thu, 22 Oct 2026 20:11:47 -0700 (PDT)
Received: from github.com ([172.178.118.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536c17b3715sm7660461cf.5.2026.10.22.20.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:11:46 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v15 00/11] Reduce the differences between
 TCP and MPTCP for TLS usage
Message-ID: <f5a36b3a-4d30-3525-5875-4112e73f4de2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 03:11:45 +0000
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

Hi Gang,

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
et-next/actions/runs/39888761240

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/2eaa2aa7c1=
1f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1191745


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
