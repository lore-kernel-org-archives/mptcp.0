Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D5218AC4
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020633; cv=none; b=dUbXZUqzSPM/24BPlu9sjT/aZZntFsmUiE/t7YNhhpw9wRYLc2dubI9AOWdz+qXBIz9w8ATZf+1OwTPuCW3iGO2mkpFUz8DwJWUo/yO49CFnFvBz1XGH7li2S4K21dJvrzurZwSVXuRWqq0B7SL6B5AQEN7C+in6AEmvbThF++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020633; c=relaxed/simple;
	bh=h6gL9J898T1XvzYrlKQwRVCwNg/K/oS885+tE+ioLdY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PwZadAJ/L/6l3OqnFpWBbrV1nJ97IWFn/jyj30UiUGdx9CTYEDPjsWrhQMSdBhUZepGY6yK2+lmIS+NX4DJs3g0V6DpKrPZ+VWPUKNd+FjU5EVpV9I+rVMJkOdup2kDe/xJCCEVsfMEYWf2yhGSllZRFVdTaLdnfmtp187XU0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCo/bUoB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCo/bUoB"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c54a9d3fcaso442084485a.2
        for <mptcp@lists.linux.dev>; Mon, 07 Apr 2025 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744020630; x=1744625430; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKXVqH8ZwPLj9nvtp0KctSYvzh7U2YtuNJuAIpyS0LY=;
        b=fCo/bUoB9TxVIiRT22wGCmQQHT68Fz8Czztyw8CDTRLXU0htDusNk29itXXCe/vgg+
         Uajf+bKu19+OYv4ZFSZuQh+Kdl44NMZoBF3vVp3JDdzhmGHPedHe6fBBeMsH7kJCTU1d
         9Fh2UQxyYgJUuMdf9+e8FRdNjzKkYTibV7+Iw7nSkIjVgl6xp+gotzcBiOSCp+Hjk6si
         iJPoUC/yD2EgfF9DKQvovTXOixcYhNhdCebtOgwHmzHqxVSW4A4inRjbnLGCIjQqlxcu
         IFwl4fOmPEjcXTKlSdzvIQmYUHRIwWGo6yIN2SEspZL0u6oHXsuCBFOM+vrDDa3X8Yc9
         ibzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744020630; x=1744625430;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dKXVqH8ZwPLj9nvtp0KctSYvzh7U2YtuNJuAIpyS0LY=;
        b=obJCsf9ZItgGoZba1aCgmzbpdGpIP9p52QS9MyjxrrripC7z1bkLIaKbsy0uMxb6O5
         a9aLmt3lfUZOd2SE6z9ukztkBxuPXBiu0+bZPChEnl9Y5vC7hGkZ2k+SvQs/S7yYx1Gu
         YUlsaIY8ddlIY2J+48xI28GvODr7iE1bj+Zg1jwBXr8xmVbNLY9+Cld3GvIM6V3W5O3g
         H5MYP9O7lxQmB3BmloOkdSLbquqIV+eKVTI138dQNTQfAyU8aTPLQLIKXcZSGEUF844Z
         /Ev+gPY+xgkxFKTlnRgE9JHLiTPE0vWvLbdeX+KbQ3mBkYZkrJqKRk+uZgXYfsuc8d/3
         lI3Q==
X-Gm-Message-State: AOJu0YxzwsvDJxsP2DqcaAiRwMPylqp1bY5mU0YnDSZxvvVWY2WFTud0
	4FN3xwKAkFkTYG6OzX3rcQNBH8A8jT49MRoslGoHl+0K/hqJsJw=
X-Gm-Gg: ASbGncuKQJqtIBuVD1dUyX6cvHVcw00IyNAvl2yLz35RBm00nyVB3/nwqvyUGT/6Li2
	IfJeE4ujhBKM7ENafh5qVjrseO6n+bEvbZAv6WzBC8Klzu0syNvgfH4nBgGCbWBqca5cHMkBUnf
	xoMGXBrbhpTeaINYht4d6reU4pnhcApTRpITVOPkZL43mrXlN31xrRYf2qQcPdvdPO1b7ZcNktz
	9oFkIv5gvl1a+sOAUiB0YLzV+dQEYrd69Vj17uV+jzdTukivaMysLRaPfGb84zDq9hb+REIYZeE
	RSITI+xV+kuShE/gnBOBjk9RiMEcQUFP+VewbvP07xwq3i4p619FfWbB
X-Google-Smtp-Source: AGHT+IEcl2yJF1kPzH4FLJncXaLfKj8CYi1qEDl9WPKieTKNQ2dbQkBD6XEZUsJVG1i62KKI4f5HfA==
X-Received: by 2002:a05:620a:29cd:b0:7c5:55f9:4bcc with SMTP id af79cd13be357-7c775ae02a3mr1749654585a.44.1744020630396;
        Mon, 07 Apr 2025 03:10:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.71.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e759a66sm576942785a.25.2025.04.07.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:10:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250407085122.1203489-1-pizhenwei@bytedance.com>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
Subject: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
Message-ID: <d419eed6-e5ef-c2b5-8a16-ce37e2993dde@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Apr 2025 10:10:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi zhenwei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/143053=
31599

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/39e4cffd418a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D950432


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
