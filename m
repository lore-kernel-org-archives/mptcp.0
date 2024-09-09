Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD381727
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849356; cv=none; b=fFeqDNuVyxgyN0hJtiLt3BrgVP8UfZ3lb2OH4qavafJ/bGovqqfmLbwWazxjfiOPvtyZ6QUomAtPjze7RRRyWyyNHDFokjfp/zQ6bDNkW4/1uQHvt8MLRvgwZijbMwugl9NL76DjKvSM+VqeplE80lGKUTVwOgkY/Z81/an0V9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849356; c=relaxed/simple;
	bh=EAooaRIzIV+6JTD0Aj8Iv8sMBrxO6r7xcPRczYDHt+A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=N+TaVcWDmy66EaNwfk0/cEHnOLPcwCRN7KRXpnk36NT0EjyJFXtQhxtMP8NMwlhYgmpGmh4im7h6FNO2NLed2sNK8OlPGINP29G3HGjg1ZN4WHALE0Fqcrksz0XIDmQgCzQD6kpLFZf10gHvtYQ4XHsLENthWQ37cAp9yEN8gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpHjL3Qj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpHjL3Qj"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2461608a12.1
        for <mptcp@lists.linux.dev>; Sun, 08 Sep 2024 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725849354; x=1726454154; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrYzyaQdrfyCbLoQhhqjp8xEU/AhckGnfdJgLS+4/o8=;
        b=JpHjL3QjwVhPcY6/EixtMf0cI0eb29POi9Nq3EsQAkLgFTzo5LoDEkj04FGRpAKiCF
         NunF2OKDSxFFBYmE0zUfZINkQ+L9V9qomKoLnVOpCZjGDBhFWMPPPcAlhYRl4udOQCbR
         e4RrM/NsaQMs2++clOuUMgMtG31XWMOIBJHGExMhaj1FOSyT8FHBbuTeSdtkd0QJSALl
         EJj3ENIPrgzM8ytop0BIfvftLfR035Oaye+I8RcQmDf7BUCuxYPiLNijyYDEPvtlOpB8
         zoi1kpc3KIJrdA21mjZjszbvyUD/+lPc5Te6+L7u3gQ0J/5eAHYnocKVRdb+OvfyOqKO
         HD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725849354; x=1726454154;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xrYzyaQdrfyCbLoQhhqjp8xEU/AhckGnfdJgLS+4/o8=;
        b=Id3+UyVg131FOUsneZ1VhXpkeeLgdOdImJHA8cqb6F9xSCi5RuOdsqj+PdtxyT/xHo
         /X6DbN3rwZKhJ68eQeG9O97wowV0PsPQoAUPaQq75lPxt446FU9Shb7MUrc1HajeDUIx
         mO12L/htpheUHd+IhKVpk9w26RHDOlFHCwXSBceiuoiWPiJ+1J42dXAIVtVtnCZV934u
         1JjJEEn9r+AVhfflu+7G/BEuaIhfy5laSGP8AfarNrHME3xXWXr6wt2wk4MiB7bpjyw6
         Pm0NYP5DmVXlVSS2ZIJf7jf+Z9qHm0N/4fmojRrRZRm9QsxuvKfLpmoKI3+I6fJYRsCT
         cYEg==
X-Gm-Message-State: AOJu0YyrZON1GoBa7yswYnf+P/DeJ8opqPwiTXR+upsjVhyW3fl/PjUr
	txXQahh+RfmUzX3uEA+FtGFHrA9N/p8poXfkjmwM4/qaR0Qe/s5Cdblm
X-Google-Smtp-Source: AGHT+IEF5uZ8bkgWB7ZbqC7EAZhptE8e6Qkb/y7CGvZPDEKxNw/U+hRIUTerlvygDhKTkV02TZFoeg==
X-Received: by 2002:a05:6a21:3318:b0:1cf:460d:8b75 with SMTP id adf61e73a8af0-1cf460d8bc5mr319087637.7.1725849354195;
        Sun, 08 Sep 2024 19:35:54 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.27.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eef0b5sm24957165ad.146.2024.09.08.19.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:35:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725845619.git.tanggeliang@kylinos.cn>
References: <cover.1725845619.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/4] add mptcp_subflow bpf_iter
Message-ID: <6dae38b7-50e5-605d-ef0e-a768714e8595@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Sep 2024 02:35:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10765143216

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/47ba4265c94f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888193


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
