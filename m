Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D51B85E3
	for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985524; cv=none; b=XoSQHm0bxvy6T8qBdW6QeV+H8rMm7b9XND5UrbHMOrM2eHkjPl00shgaSJn1+HwRMT8Mt3c6ewAODmtQponddZmjxlmulm+ijpbezncENSZK89MuVVzPgQgVaJlZrQ4wCECgLAmK2YsLSohUpv1infJ8inAtYISpi5rmVXH8HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985524; c=relaxed/simple;
	bh=WocJke8eyQVlmitAGaLwG4CFHCmQiW94pTw16p+oOeQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NRdlcDT6hz8R8zh+C+0zKyjTUSMLWDdDpS2aipmsKfipZXYSrMxyeBeY60fLU/EsY28xWUYI9niqVwNShdMCPyyjJzMsNSoHSwBiqdASeiWvwR/2OuRpZ7H84jg+vQNGTyoOVexGsmdET9JqPbvXtlRjyYav6izSncAuT/tmdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KenPNZbc; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KenPNZbc"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb97afcec9so45589606d6.2
        for <mptcp@lists.linux.dev>; Tue, 15 Oct 2024 02:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728985521; x=1729590321; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNOFRtVgfVdbU4Yly6IbntW33SkdW9ReJ/BCYxNvwDk=;
        b=KenPNZbchIUI9j4jcTtUHHZN6g3FLS8Z+eD/nql4/TpHLguPn/EPV9vWtjRheuJyKf
         iZfOuSb7zOeEJMyV7ubprRRxjIMmbxlD30A6AJZippM+ehX6uO1sdeCQ43k6DEAM4A+5
         +eFLQORzq30y3nhL+Zhv8swMZ8YU01EGzDccAZ73L1+za7ALabk7FeTzjRRaHPCqp8pa
         fiqcaBUG2sYoWF7qzT9WuVMW6BJmgQTOXyA6iVN8snAXnJ9mU8V1gkZZu0C9N6k11Ap8
         pkReT+HdzqZJWrEY3bLfP5EXsTNH9HUwNeoCDVYbFmvNqYes9iaaspqAQyTeQus19/EC
         sgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985521; x=1729590321;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VNOFRtVgfVdbU4Yly6IbntW33SkdW9ReJ/BCYxNvwDk=;
        b=usIAFMBa3K4s6KM+7CGdI8smmH0C0wt/mRRngRi+4Ov2gSRqXSdY5e6Lo34pVlwB1L
         ngne48cPN/RIQcW0c+0/q+ClgRDYgklUBko737T5yHkRMZ5ZcqI/9fVjPp1dhWiT1FJ7
         26UoCNOgR/4gBHfimUSp5jws476YyLDhzoRT0dQULVwdfbVb029hcYsY6aBIOeErrXLg
         PtsLT88D/xc84LKRJlOlNAApy6INmT9VjYs9JqIJsKR9lZnKtVnWnBUyrOzYsJidjazH
         YIiityrQtGRpeFM3dWHoX6OIPbJ79JkUYmuMKiKuu3alL5+mqGC1stEpYVfgNTT74eay
         3BQw==
X-Gm-Message-State: AOJu0YyMREygVpzRdwStiuzGaVvb5jx/7sd6aeKiTZ5vDgPRnF7Eoc29
	q7c34ZVjSi06EsKJkz5Bg2zvq3Wbtn1gvAlSs2J07srP7XFvboQ=
X-Google-Smtp-Source: AGHT+IGLh1dOj1UxxLj+R7CKdQqkNwsXWBmAYGZZ/Idg024uRut7hCcN10dghzJjwpKLnYx8tx3VYQ==
X-Received: by 2002:a05:6214:5d8a:b0:6cb:e9a5:acfb with SMTP id 6a1803df08f44-6cbf00069c4mr227695496d6.38.1728985521536;
        Tue, 15 Oct 2024 02:45:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.191.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22961c43sm4656306d6.122.2024.10.15.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:45:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org>
References: <20241015-net-mptcp-uaf-pm-rm-v1-1-c4ee5d987a64@kernel.org>
Subject: Re: [PATCH net] mptcp: pm: fix UaF read in
 mptcp_pm_nl_rm_addr_or_subflow
Message-ID: <3e864a33-a9f1-448c-769b-339a0597293e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Oct 2024 09:45:19 +0000
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
uns/11342595780

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/10840610d522
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D899195


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
