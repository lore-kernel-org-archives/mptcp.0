Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB5E170A3D
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173033; cv=none; b=iUldP8cQswciURHUQ4i0Pc+Mnv+PJUaupaVZlHWdDJaDDL/1aj5DKXhMB2AYFQpQ3UgYzHZPhtrEmyssLOb9WMPA0uPcTkMD65DsurfY3v75l235WQE5Mvm+i8m3r0lfxlffETtvn9lgZazWt5q0oE02pBnR+WSoqIRA/WRfSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173033; c=relaxed/simple;
	bh=joutximMFz39akIkvejO8XfNLqHd8pm6bvRZQ4Nlc7A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GquZVaTqwn5ZDK782pho9ZjCYvfkWYC/k2YcmuqgbHsxSX8CfL1l4KK8mtezmFadpOSZ6DCI3rbw8+VmOrup98BcerTab9SVuXjVL3jB8YqSqa2lu5y67crTr7LJQAFZ8bYY8ZyxGYMSaaLPhNkLPGhl3LBlTOGcJKevL5Qs7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvBNtxvJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvBNtxvJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45821ebb4e6so41923521cf.2
        for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727173031; x=1727777831; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jclJvcFIk1de5qqEzWBLZvMtb4xkVyngOxZsHByQ2/o=;
        b=DvBNtxvJXvJ9esKHdrV6BBMvNaTLwWCVGzWmtoXSFd34r6ccwdqGvKMjUM8lsUR7wJ
         E4o+hZmFM/bpiXPod5WA12rtBtvEhqMRNGa5epnMBRkj3bh0lLxrY9GoWMiiU1TK7MNZ
         9wgCySRBsgNn/OQbNRp1u8iA2Ynm0yaa+/r1EAB9Ss3almWsW6OYHwiCsMkzQYVojPU3
         RoCk3W9WZLx0Ketn7IRv7LDqtelSs3u7hSaa3QC+WhhZpt79Cqpd7mdQyRaDlxm+urqa
         mvChz/pIP4AZpoSpzUWN3WrOpRr8K9k83FreGbW3lqSueKFbtzVWwbStPXkPYFH/eZdV
         dtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727173031; x=1727777831;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jclJvcFIk1de5qqEzWBLZvMtb4xkVyngOxZsHByQ2/o=;
        b=vqzmaVff35IGppZuEjHGcaeQsAapVoIUD4EWi53TmER2YeZ1Meohv1qOUENwlzJ9ar
         C1ndlPOilxOwd2jpacQB0zYkRuu/558iILTwmCYc2M6OuNqLetqyVnxrc2948pzNM2mB
         AnMu8HhSUywPQHgxHqRT3rxsEykRqGq0oeCB6bA9AUWKHFlc1d+NRM6/SUoJk2NuEKRo
         w73jTfBmEFUClSk79tFyu8S6B38MtwoQVpi+Ghd+SROWHiiPElnYfiGbgvVUKC1eWzxI
         KLu+Q+b+8Mm/M2YF6elbKBd6cvUZga2aH80SUw/76Ejf62E+1D6tJZNMszj37+RRf6zz
         yZOA==
X-Gm-Message-State: AOJu0YyNYYhtiTgWq8TTpzZZRy0xmWm3ASLHBOlKwATkKHRjCfbLX/s/
	53rjuPS0wPnbE46HPNC2vkdrb7DpYyU0dan4NrQDYerCSaALB2KRrPCvj0E=
X-Google-Smtp-Source: AGHT+IEJOpoxGiQYa1aUiLEXXcmLZwroZGl9Q5b3jPsjXX63TIgz849max6CbKwyw858hqo2vB/tfQ==
X-Received: by 2002:a05:622a:19a9:b0:458:3032:f45e with SMTP id d75a77b69052e-45b226c848fmr220189441cf.12.1727173030721;
        Tue, 24 Sep 2024 03:17:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.215.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5268afb4sm4830961cf.82.2024.09.24.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 03:17:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 00/10] add mptcp_subflow bpf_iter
Message-ID: <7da38e1b-7d64-2a43-43ea-2c0ad79351b0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Sep 2024 10:17:08 +0000
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
uns/11011018561

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fe0ed2ed48f9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D892355


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
