Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4D3515C8
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992391; cv=none; b=rZvGIBzy+wfq8gVAt9843DlJLsHJTeKQkdz6AQHBpmxgwhPv/YnN6GpIzy9CKK6SKjy3DJZGMcHIvE2WlAdA/yBSL+vZrG1alGROJMZ+Y1KL6OvgKPToGhrm9X4j/ZhCQ2ggJxTXn+BmM36idS/ampWajQxr2yM920J+Vek6MUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992391; c=relaxed/simple;
	bh=x4dLW4BX6sgpbsxCO9qFn4QRu0BfWA39oiWoGsSqPKU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=SkAdFgNoc2UGZwE0dokMdyqw7ABGgDUyhWgTm2jGF6CT1/u5qnV0VwCWNzWuds9Wj2TVD63NCN4KuGEdqKme0ra0N8+0oxUEjZA879axd2btDXxhU9p7ifqMV51FMIUX273wy/Vjlo5NawZatJAmVMrj3fbq8JrHaeGn8Hb78Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzL2bOZN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzL2bOZN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8d2574fd9so27369155ad.1
        for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992390; x=1792597190; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FKlXwinWhKKOvQWdhu6fCifP9EWCG9odmbkkLyjjcLQ=;
        b=TzL2bOZNYaM9suQ9YgHWq6KjWp72AwLnoJy9a7x6c7LakGT9VURySfys7RypF7jXol
         wE2TK4FQO1aNiahuoKNgKJtQPzGSc4DYQeXwY9zXxxUKyDQ9vCiixXCtiGJbuZHVVYeA
         Y1MieAYE5x4cFYU/JjGDYUNnV5X2338y3AK7E+CpE07LjKUHBih9sgzx7XisYy9DDUUb
         nBR5t5jH/6v2JK1QjatMrZkULEX1xhFKUy8qNAKcwra742F3ZFzMYLJOzTgcy93vc3Ka
         Sxb11YDgbk5lHZ9MZoZGuFtOX6baDnPH2HtoGVIVAddpqkLv0RCdlVciWFZowV+BwB8Y
         3v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992390; x=1792597190;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKlXwinWhKKOvQWdhu6fCifP9EWCG9odmbkkLyjjcLQ=;
        b=UxGO5UUTiSPl24kpnNLwga22zVM9vdfxkJqEUvYh8s/+Q0D6vH4Kpw8w3Tqzrq7E0j
         RqL0nCmBggwD56/WAQKiLdY5XRSrmoZkYopEPhAohTIYR0chGOwGFXiK2MC2ys3jwmX3
         ybU5qpWa3pDBL00Ys7pNgBTkpCX9KFprOU/CmmFB7z2eJ5/VpIFWnpvwJNnuO9X196As
         NbcdWnlj6yijYG/FvnkEcgquNiRtS2UYjtpKGhUMyl9oX9J5LObkyyHrloH7OxhfIbzz
         Avbi9GAO06HcKCCJ6/qTKm85UGUpDYd1VA6cx+b++sobOXKukfSBK+nSAa7uJYdK2a+m
         yhzw==
X-Gm-Message-State: AFq9FYJ7NdUQCFgLa03PrlS+c/Ph/PwZQAZebKOKWGiNJBcqbW5NrCph
	3F/AvDb0sabY7xNZgxgTb+hJvjUDFhdEv15tRQapklHamo5CZ15leKs=
X-Gm-Gg: AYBFou3MdqHX2+/BKgSr/WcIkSHE5t+SxwnUxJTOF6I+M5C0DQS99KYnhVMXT2dqdFD
	VWg81GX5U9LDZ5ll8PbAlivrnoaEE2h6ufWJdNwa26JrYMw/SKiKbqswaoplDpVRIAq7BZfldfl
	ojmVcbZK/AEtQ/KdaUXCihPMsuwq5rzsEcuaSMjTLAvKJM2+P9FUDGduR1XKDypZDa28npGXGWz
	wZqegwdRrgH2nOp/7qWvOgiCJLIBBLSzk4yBOKZiOSEon5c5K3Qy9RG6LFT1XjRhfcPT5/juNZb
	q0kD8FxxRtL35E3aXkmSUz7fB7YUuTISktS/+kyUm3DfOoPNOWoYeORyLc8uqyL8+7+GM4DImhP
	R/nsR5eSMfO5rdXxN15kiCAqbh9rc00TnLiNIYi4oCux3pBo67qsa2yDqCb5GqwH/1A13/wqYqN
	1qPvO2pPU/rPuGXFLuHKd+azOauO3UrV/zzwQIcpnKbmn3cOvFx7xOdiciL6yYuy320OWBkMLyO
	8skVhQHjS4=
X-Received: by 2002:a17:902:e54f:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2e842aa7c60mr137575495ad.18.1791992389627;
        Wed, 14 Oct 2026 08:39:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.39.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b298dsm69752615ad.33.2026.10.14.08.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:39:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
Subject: Re: [RFC PATCH mptcp-next v3 0/3] mptcp: pm: kernel: retry
 subflows closed after an error
Message-ID: <f57d3c57-d40c-0325-7437-e9e04fb1c86d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:39:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Anil,

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
et-next/actions/runs/38583978482

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/06eef3d66a=
29
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1185663


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
