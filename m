Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BD1E3769
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748633947; cv=none; b=Je4efEbNRfk6zHwQR00Z91mLDSLTN55Bzu5LT2o0v96ScBdxn6obc8KXD/KcSHIUfJ/M5xszW6HIK1HZGnpJestuNdr9T5trml+bBxIApVhXo2bYwcpqDmGJpV0+MdqOgyBFYjyNYknm+CSAvIDYbDpWaiB30FSAi4T+IyiXl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748633947; c=relaxed/simple;
	bh=tCDWBjxrie2ZZBQMM9xODJaDuGShNAC/qpY5YSQol1M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kQ+TNfNE8J1upVvxIYGvw0Nl/0NqjUBr48h9XGt0IsYjECLWNtUdJEcHxvK5KN3YihImNaX2Y5Sa5DHCRJmX78WK+RwjsQylt5MlgKuvuFjUz9G9uZNHmhQbbLihVDgxCVTTsv/38cTmcahiTqET1GTIuQ5s/JMM6AwGLBDnykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/IstW0d; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/IstW0d"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74267c68c11so1988082b3a.0
        for <mptcp@lists.linux.dev>; Fri, 30 May 2025 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748633945; x=1749238745; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/Z8FxALogWdLovY9fPkrciHjfa9CL02A4ViTGA09JY=;
        b=I/IstW0dtIO7wdINCoeMxRZYIZdOmyHqNDiz4hTLP3jILJAk0FanRjWVQLUWM7uvrh
         Wd5X7+sl/PeBCzo+LLEF8ky8q6Fx+5Py1agazL5iFBO2JrjLWMy91l861itgyPZ7muzd
         bawsedxTazo09A//N/KeUa02J61e6Ai7AX6V+vO43c9prvwvrgiZQvUaXm/s9H0jxUyq
         3GEu3NhkXlWV2jdlqP3DlYqbYeOZ/k42Mu5QTbW2N0kVTRgCR72Cfp5fqZ0D3zHMbGeL
         qWY5u1rZHKK08c+0nPPl3MTmXtGnmv84RWvGCbSvYmN6Vb0J5TNqPjWkxsEU/8ITFaQJ
         IOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748633945; x=1749238745;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/Z8FxALogWdLovY9fPkrciHjfa9CL02A4ViTGA09JY=;
        b=TAjZ/mdzcR0g6Qnsn/7vsZx/O7cX0urp3p0V6IkoeLT0EPrIDN2u2LUGVJDUXijKHO
         HM3BNkOtSdFjM4vDXV8xFMKQs3XS6k4NF+mrxJuZqW+U/FNWxlx9UHa5+znBjK2+yPTB
         QtStKO3Vx7BhCdKDmrrSrYaf2va8XEJFdeNlVuYNA9ktFqZlSIF+b+CZ4ANvR7ZUCWLu
         sJRBQsM8e6Z0UBMSH1Hclvzu+xJxQjChlHP10pkWxugnc4AAsD+CfqPcXUBebC0X/ok0
         D+qcx6Isc7yqvd4vhwZA75EgjLqqW6dz8s6+WAFc5hAZGLUTjeaP2xQjPgqCWJZXKAiK
         ZT4g==
X-Gm-Message-State: AOJu0YwynlayejQ4C9hnjjLzPG7w2j5x7IVBW1qtR5ZyOjjqL6xuq3If
	r6WDPI6Ttow2jRIrT4EL3hKqjYLHy9K2H1Jx728CjfdSiP05xIZI2p4ED9gA
X-Gm-Gg: ASbGncu+qcMi9nzjtwly1nKTsBi3T/dp9UKi5QXwPrIYXUIUjqK7k5xtYVLJ7JpAxnp
	TnNGEZfcXwDobJZl/KffxkkchHyKPIDGVQxthuTnlQolqAzHpHxsnVQG4Y8zppGIsyt8SCqNg/N
	9ek6vFpY+EHAXDmEwMqxu5q0uzfZWLfqtQ1bh7unFZhVKYcYdF0edq0T0BdqvNZur2AzwY6C5L9
	NM4CnbaculK6H4jX179hCY6Z9psXQ8eU7701VXwQrBDlWMbvKKTYZGICASNKk2hj0HG+Mkcnvro
	4L1CaDc/JlTMdUMtMuQAo2r/k04Y//N+f9Ui4wpWu85ByeCtdgYB8d9BaYtWxqk=
X-Google-Smtp-Source: AGHT+IHe6Etp0M47UiFbABxesKow/opyqyNeA0aRnMHcGoL2i6PkC9uROxJypyxUdYouNIGqSlWDQw==
X-Received: by 2002:a05:6a00:1793:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-747c1c5f723mr4621146b3a.21.1748633945234;
        Fri, 30 May 2025 12:39:05 -0700 (PDT)
Received: from [127.0.0.1] ([168.61.76.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff749esm3498575b3a.176.2025.05.30.12.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 12:39:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: moyuanhao <moyuanhao3676@163.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250530181004.261417-1-moyuanhao3676@163.com>
References: <20250530181004.261417-1-moyuanhao3676@163.com>
Subject: Re: [PATCH] mptcp: fix typos in comments
Message-ID: <c6309fc4-cdaf-44cd-f37d-e22e70ab04b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 May 2025 19:39:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi moyuanhao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15353341784

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2f1e0a2fa2a3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D967693


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
