Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6F18B06
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQeMxUON"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d50d0c98c3so65586175ad.1
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 11:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705347294; x=1705952094; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFFtd1hSy0geoaCbWESzsZW+xTSGAzG2VrIusYhw4sg=;
        b=ZQeMxUON0sRRqhk6FpTxTFhBYkhsL7TgLrS2X6/RZdlEX3B9Y72HX92sUCqrv2Ao7i
         BFW3HtFKra9Ijpni8gB9kufx/22y5g2ajOObW1mPoy7+IS5vO/csJxXHqrWoOq0pnVKx
         QdpMPfcpv+6c14Agywc201MHTKNweFpUzF5WNaHxNVV6I4QEgfuyG9KkYNUqavG5PHmq
         26iOJh/p35sM4FQR9xmD6dSP3VajWXvddQmCfVooZSzPyjeoa7Iyx6mu+s4pyXmqmwxg
         uBdxewCkzasa+YZBzcnhTNFI+8NKs37+MUSRs4r1nAi/9rEDSRAUWtESS+3ANQxttzZ4
         D3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705347294; x=1705952094;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OFFtd1hSy0geoaCbWESzsZW+xTSGAzG2VrIusYhw4sg=;
        b=Cj9PT4eMUJrL/vaZpEMgH43Jc/90Dc99F4uWMD6dBD4ZNH8FYHB52WdFgtaraUuZ6I
         xKkSlTwp0mFfuK1RGMLPjqK8m9KF6S2nUMy7UEJfZKZsTt9wDUmqxDkPWIqWigEkgjnF
         RnJtB11BX8q1Eb4NPpQH+HuqAJSjkgHJxycHFY1QbNMYyZNo1qiELfMLQDb+0s5I6nAD
         ogWQwlaXFC+6kCB3oYZcD6+kWTt5WCUwskquGSeQcX6bdgNDy+o6sSIL31S9HXyEEryO
         znce1J/4G2+s3I32pz5G0QyDIxnPFuSEMuF0R9dkzIm4MY1ku6gTcMFhYM4A2X+c3fOg
         j84w==
X-Gm-Message-State: AOJu0YxFFOTnFxygC9TJThtenD/T++2BSPH/a5kWNoG+oE+1+HEYUNfc
	Egm4nlmUoPFY6AvwA7188A==
X-Google-Smtp-Source: AGHT+IFjOr95+M9uRlsTHas8aUF/xNCaDY5JWyIw62Vkyfm1Z8jgPYjH7CdDtsNmBCgDTd0cvDLchg==
X-Received: by 2002:a17:903:1cc:b0:1d4:bd18:7c47 with SMTP id e12-20020a17090301cc00b001d4bd187c47mr8230945plh.57.1705347293657;
        Mon, 15 Jan 2024 11:34:53 -0800 (PST)
Received: from [127.0.0.1] ([4.227.115.0])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902934900b001d4c47bb5cbsm7957835plp.257.2024.01.15.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 11:34:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d97d56012abb6e277c4ffc5042ff2f414dbe7959.1705343249.git.pabeni@redhat.com>
References:
 <d97d56012abb6e277c4ffc5042ff2f414dbe7959.1705343249.git.pabeni@redhat.com>
Subject: Re: mptcp: relax check on MPC passive fallback: Tests Results
Message-ID: <8f8780d1-95fa-6baa-82e6-34a9d184def1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 19:34:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7532921194

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cff2320d6411


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
