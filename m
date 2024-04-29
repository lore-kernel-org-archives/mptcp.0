Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC11E529
	for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416735; cv=none; b=MoVokjhmTe+VrhzBoYOuuGRXKokiluy1Cd4kaGr/YOQ3fAiGn3EyiZKLMmjgYocQkvO8gQ49APoYOk942A1FxQAEwrdijVKAwnZzX+lDTXSy/OWWoD9J8d/GO/iVttmrybR90uH6pnn18rmzF5ISrJ0n3m+N86qEhaegk7D9KfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416735; c=relaxed/simple;
	bh=9v97ReRmX9P8FoJe3egOpFR4N7nhYbXp1JgdG8fid4A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nPH2e40KspV9NkFDZH7gFkHRswfHWeWd5mQAmKILtB4934A5M75MDg08P5KOp1VeevVleT7uVRyakuI49QdfbtTC3ktrLX7J5bcxdDp4F2vv1w+2WCd5JApp2F6TI83FIKP7PyZYmGwpmvLIw8+mEc/WSWgW4QZke6La/x1IWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzD6ECYq; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzD6ECYq"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ee2a193a45so655238a34.1
        for <mptcp@lists.linux.dev>; Mon, 29 Apr 2024 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714416733; x=1715021533; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDjw+Xz0UnQC7sfAfkjXG9TtKG2o+rgumafM59klez8=;
        b=dzD6ECYqOGg8L/WFphWsJONgUmU7t+EpZiPrh6Fm3i7Kca/MEh96u+IuHtuwK5Y0Su
         1B2Im2g0vIdHkJeo55r4dQhex3YtbA/gbXZhwXMB1mG6BBy34gjaCxcFEawilXS38lI4
         s8cEYXBk/Cqb/z1eOut5UcPTbLfENDHrlICfVxe6HT7WpoNF0BBWVoHSntVK/WoQx2q6
         fva7RFJPyCOxQNLJVsW6/tsPLCJfkFwj/DMd5/VZ6ao1LjhZqP5Ll7lmYGMlJCF6/x0h
         mMDYgSzwJu5iBSQ2vma/yhQMSa/wRZcfgPia7LbKb/IPHrXkqSnIwF7gWBxM6O5lZOsB
         PFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416733; x=1715021533;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDjw+Xz0UnQC7sfAfkjXG9TtKG2o+rgumafM59klez8=;
        b=Ilm3Mnw2kFT2Hugi90fSwOqrO3i6h5Suf7Yv5awltW9ArrojmQfhOcQSjYbvw0hENW
         wo7Mv8K4Lgt1KEGPlEK+xfha5Ow/26XHb4MH1QvVJIAon+fLr0nI7SeaIL4+yauS+qNw
         HsBRgrKxCq01o/p2WPfKOQK7odTZOYK9vuQlctRdyQOsPqQH9/d+zmNJ/YdiKwFfeTsO
         jvzgaIDembRRbOBY9JLiAQtUaJl6qYtp/BxtVewiZCtFYyBaxfXUyznJkjyv/iIgb01l
         OmdL3BpGQao6QqjfQD+SZzBRce2hQiiAX3h6E2WFuk6RW4H2xKs4FLIDpKbjH+7vLtuT
         X2Vw==
X-Gm-Message-State: AOJu0YyfjXuRmUq28Rq83azbtMKApmdOzQRb9/VN0hnOy/RTXr+CX1NC
	41xGvTqZt2GxokpcbaSxnMHEd8HHUeaIBTcfAGdr3Y+p5ZlGWwkSkDb6
X-Google-Smtp-Source: AGHT+IHW8g6E+vfc8RuwZTZFp/Msv3DYyr8RwTsVMcMY3YS+bKezT+xH6t43o0IPVzPvncDhVdd5Jw==
X-Received: by 2002:a05:6830:ec4:b0:6ee:360e:e11d with SMTP id dq4-20020a0568300ec400b006ee360ee11dmr3607696otb.35.1714416733238;
        Mon, 29 Apr 2024 11:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.82.219])
        by smtp.gmail.com with ESMTPSA id v20-20020a05620a0a9400b007909dc09269sm4098556qkg.16.2024.04.29.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:52:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default
Message-ID: <3a9ed2a9-7ed2-cce2-db41-785f05d87598@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Apr 2024 18:52:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8883431073

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2ee47022e74b
Patchwork:=20


If there are some issues, you can reproduce them using the same environment=
 as
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
