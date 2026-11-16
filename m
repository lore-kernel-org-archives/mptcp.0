Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836337;
	b=z+YsWFH6EViYgJKfz0LjsAk8jyyGzI6jCv4vfOLRzneC0tn458LLw5pd21QOFldtATpT
	 sub6JAu4OYPVxbMt8pUPqz4nBb07+J9096XM/Nu9RWHEleKUNeb5OvzneHJEHjovi/yq1
	 ZSYKelHYH5SbPla//L7nAj9jFsQpK/Pxp90BJ4l/SRu8PIxtb1q8dS+AC4wkB7r1pQ63O
	 l/Z42v5+p5iu7SA1tXLe7zaItk8dJQuHDHkFe1FdSxoyM2VZPNNbr/UQhCCpEA5Q+9MSQ
	 PutivvD+H6cPrLm0NCFloyRbS92E3HDER49OZ+dMSyNFm/U0haN5itT3qGDhA2sMoXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=HB+lD6yXhjSWWLXC594vnNIr6gJygewtbeT4F8BHMyk=;
	b=p/EsdjHDiQf5rzhU6tvUPT3dsHGqBRe68josEBYCRIqMT68SHwovBX2gly4eQKJ4aD4M
	 NuITZEGawvXlLXos9OmT2be1kL6M8PBYnVDOOz6q4Rj2PMK12bqM/ggQXevZOX4UC29eA
	 q2dLrrtZ+e2rjWbTp33UUBgY//Jc0E7UdmVCGppJBWneLA8MA6KapAY2D52/vuDRDsxjn
	 P429k1xZhRpIumhugwguYpQzf8guFnYMgykflWAjMbKtEZXh79xRVxmVW64GW8Ibg75Fd
	 zvRREkUjgrVdajTGw0yNMGC2MN3DT3Ckt+j63Vzui1EvmYSUkhKfVrWkfo4TSumjIVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5r+z2rU;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A7606A323
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 13:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 076A7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e5r+z2rU
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-51f2e9e6987so3692744b6e.1
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 05:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836336; x=1795441136; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HB+lD6yXhjSWWLXC594vnNIr6gJygewtbeT4F8BHMyk=;
        b=e5r+z2rU7Jq7gUceHEiUIVrU+CtLUn1E/TOrxHiICgqI7Sn5XHNyRsR7wzRa31kEWe
         Dh4qFxYoVn6p38UkPCp9Ab0tXYkoTLEFHscKRLngwAhbeNl90LFYsZkmiX4x6JI9fdea
         Us1ae586moDaTlFoK6DOyV67rjNYyr3q6XOmqMZOhrpjcp4qpByltc+E6X4p5J8YfSGd
         CruoP7AG/fz5NWZO3xII/tkRUehBVIdYhjS8hdTEcYTEBrgYKMmaEt8XITzrRVao2sU+
         8lDS7dLXPZKFPNxW41sISHUSW0YSEqxQl61vQBYuJ4Xrse6yIXyLzjuvUe49ykIaJi2a
         Vhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836336; x=1795441136;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HB+lD6yXhjSWWLXC594vnNIr6gJygewtbeT4F8BHMyk=;
        b=EN+84nn4A5cUPrue54qGK90JKq6P/qXK3YbKRpl9stzox/ASJGtQTfFqZsn1q2+R3k
         JAiOLLBvswbm4d2UZ76NHGTSzxuF3yAgmcX4gi0LqKS7ObaepLDAlpa6KnmSjhQYEdaG
         Yy3Jlat3RJq0l8bTW4aVGb59nr0v4eZhyRQKBlOUbeC0kw7rHriOc3MKuUBl/588MCkn
         gNrxQ4DWakysxS6Z1uhWtVphmNpOHL42sX9J+8FfhbuEKKuJlfrDAbOCAzPkCITVOAGr
         2pq45k/6U5t4doT2gn7ZDwCEHnhGTBGA/FxrBHosDbNw2/3Vun8+h73CcC1mpIkXTxNd
         PJeA==
X-Gm-Message-State: APuU4Z/GJ70sSqfLAzf23vpE0/bP9fexEzkoncTHAY0xgflKWsPyv8uI
	RBpCs3XOZrieAf10kGzPuWX2rIvwrutspyZ8YPC3J6P4jmPdBsvQg9fW1Xhqoig=
X-Gm-Gg: AYBFou07RIrIpt58hwBi12ZKi9ICceFDZYRKSJthj3NETzeqG95YCWk/59Fs5Ol6pAg
	2r1mwcJyyGQXUhsBQHjIhmDpORefdnyF+rDXbH+w4vTVJaXirLWOFHWnAbuWt0A3xAd/RnlGvPS
	qGb9ZKozJvHbLs/UalAU1PKUGz2c8rokz154/qDxrUDFaJ2dBD8+G5i8i+/2jQvwmTq9w4wek22
	E16j4Do7CK7AHi2NZCCGcVyVnoOXZUbje7VofXG3Dea+wqUpfhNliHkp8BbhONK0M3NneW5krIk
	C3nLGEb/x4A0JSoLTJ/bAGvxALLB5LCbXypNIkcaW4OG4qR0Sw9wC7g7cqV9jOWM9kNOa3hOljk
	ya5vyO/Y0iNXTzxkPBvZJCV8mpuylQZsa2cxwRzrrbHTnHX3pb4ZiWY9w7WVFnb60CybvJnDtIZ
	2cK5VTPG4rTtEbPsCmWoohkXgMOms0FfKb1vpE2s+pbi16Tjraeq6l9vj1QsQ+3jy5y+Vj4Dsss
	i5AILmReadXgXfY11JtGSoLXRe2ajg7CmnTFC98wZOObRJ4Ix8REnm/EOE11ssuhbW4d1+1f9Ej
	A4xNhpc/f6QzaBnZVLaI8mj81zaVbIUdv7NspEZnGw==
X-Received: by 2002:a05:6808:1583:b0:4dd:f8bb:e1bd with SMTP id 5614622812f47-56cd761bc32mr8304020b6e.13.1794836335923;
        Mon, 16 Nov 2026 05:38:55 -0800 (PST)
Received: from github.com ([48.221.154.57])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57571bd20b3sm527283b6e.8.2026.11.16.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:38:55 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next v8 0/7] prepare interfaces for kTLS and
 sockmap support
Message-ID: <a6dfdf95-7143-e5a0-cda3-deceeea87a05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 13:38:54 +0000
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
et-next/actions/runs/43862767956

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ea5be39da6=
28
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1212621


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
