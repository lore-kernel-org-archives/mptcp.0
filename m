Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0731340D86
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186763; cv=none; b=GEa6Aq/YMBU+WKVLB/eZPu+0+RBTFvfwRJHMur+YgUvuSOR6D7hi2Z+b+XuCx5mIb/nkXQzxI6d6qH3zIzolo8v8ZxJJ95Bq5RU9tAEbLibjDiknnc/sYdgZr1AtgW94cQ1DAjeESrLccq3zoa0uIxQxv+u9Dim0xHWMZ86IKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186763; c=relaxed/simple;
	bh=C8Ex5ML3leYtOBkxg9NIQzMmhoTxfpTVHr+hUr+GoPU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WIQQB6FxtBO+A9/g4aJnBDLCWQw0ALstHysWRxlzDoHGrvt1o1hcIJoDE2n5FeL2vmv0jcVGybUb5t3ApWaMwqqU8sGIQJB2NX2jnnZuLAC3KFSAOVChafrbSE+xRmHB1lRPoV1onuB9+ckueBLN4UUiZ7rkFAet1dBB2TwGGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhjzkNae; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhjzkNae"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso110707b3a.1
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 11:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186761; x=1764791561; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ir615hZ2lIWbGgLOtqJOCxfN8/CcrZ7IQZY24VKoz4=;
        b=DhjzkNaeNDMXpJ+bMmGY1mKPhRdVMLzEMrxJWla/3PDzfF3cwHSAfdPdwZW3jrEQdQ
         Cc4jxZzFp0wVd3KEJ2CS/mzn4AW9PhGlxCGYnFvV25tMa3urQWiMVJgyIIOTcTBgN0Br
         +eXhCeIs2cRhijF4W1e3jmgSNEfOgADqmkFVGofTihi+X6WLzRlNkNTJEn45E1whYTS2
         tpMWAXs2cNaNMMZ6PFBahvk+x+xCKT9pZcxElZDFzRQblnTE5u8U89k9eiX3ly2HsySh
         A45uz5XLcn7m8Tlh8BdYEIMIB7hvahPPelkLKGBHS5oizx3LNrIpaZHVriGqrU3Zxuw3
         Dm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186761; x=1764791561;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ir615hZ2lIWbGgLOtqJOCxfN8/CcrZ7IQZY24VKoz4=;
        b=oZayh2baU97jnmnmL6VzM3ZceJJ2KogaXkjIsb6Lrul7V5DptCECUlgQuE9OUBVE0q
         dEbr1/5OmSVpSVTR5qKVujoPtukcci+UD0Ay7imDPawyR80vdzG1IHiVuB5JqdWCXyt5
         nyI1HwsmWCLIV48eDoHOp06iHUtso9sreNY9iLyZqsiKzTSdbV1lKoht/g1Ropx6Bben
         ow241qQ97hMz52qE6e2S9wjZCWt7koBeH8tgfpOrZAceBEIhgzKKrtAJPzzo4MUqAIpY
         ZLReZ8NxENJeVqz1vTUJwfq2+qmdhsUuPUXgs9wMXmJsCFLv1JXTp9XouHeQzUjhyTZy
         zcQg==
X-Gm-Message-State: AOJu0YwpYDQF15rXQZ+Prj+JTJ4hvq6n8QwZIWNdxXffP+EOCstecE10
	cLKe2Mu4NXNUJMCzhMdG/joYBJAc3/YmKrtqN/2DSZxjBGtCj8jAI7k=
X-Gm-Gg: ASbGncvmB0SxPNR80D2I8EeOGmOTrzgiO1jL5ELO0hw+QiKTds/QG5xutuTpf2c5hM9
	0rRGS5Gd5TBqPYo4HoOD9TZoc5tjTWB8f3mhdPJWYXNPGAEWaf3U+73K38CDkWIuDAp1X6EGxYQ
	joDeSxdKSv2tEWwkT+PChvdOglOevSQqw6NPc6WM+wn63/ZZCI+GUbSMqkjyuqrFfbCbis1vmSp
	C+OxS7hm0HfDAqQCjjU3AtucgF2tvJl2K3mboPMFYGvzhq3f7v+fRrylGdEtfmhDKeXFFPhEk7o
	N8LkQbkaUArIFtiUodeWugDkU72e0ibcYeRRn+bLbdjnFv6wdSHT2u7vwhY7oLMxadChcJ91KI5
	hgkMdBLIhNPfc9oq//91Sbht4RPJ6yRJrCDyYL0GojVboI87fi9U/r0KpGI10Ma+MgAHeCuM+8i
	N3WGxB75Ehe1dtPxRnDgPvuxZW
X-Google-Smtp-Source: AGHT+IGFF+jXlC4kYzUAEUm/zQ7c76DTHBPkfIAKkRa0mPetiVcho9W07uDlRtjsqFT5lVdZb8SN6w==
X-Received: by 2002:a05:6a00:22c5:b0:7ab:6fdb:1d3a with SMTP id d2e1a72fcca58-7c58e1118d8mr23166279b3a.16.1764186760888;
        Wed, 26 Nov 2025 11:52:40 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d55b71sm22569716b3a.55.2025.11.26.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:52:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
References:
 <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: pm: ignore unknown endpoint flags
Message-ID: <7b02f287-e106-9d9a-638d-5176474a5bf0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Nov 2025 19:52:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19714326364

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2a19986e53c8
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1027994


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
