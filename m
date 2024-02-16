Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7EF9DB
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072483; cv=none; b=VlVVFOIx0oiKye53fSxATH8VCPL523u7CFj0/H//YHraR00xCdJNM+w0hELrboMsaWAK1zeiw6cQWxMMiN4OZ76hYupclkX37YGKsDzrdoikd5kxlTJi16m5rh7LbKZj4sriggCNSPzEnl0iPKPbO0ADHhtv1Aa7YuOs6FkhmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072483; c=relaxed/simple;
	bh=hK6HfXHF3jUWxMvXtlRufPtTDZO4Td5bDb+CD8ReLXQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=USwkyC550iuPo9P0xH+l/hZsmKh99nDpMSZw7UGSQ45VQ6jW1tQkaPbgzwgUB9zeLPqdcQ8Rlw/rNwsBv+BoaigArSaU0xPIj7sRPKUw6AWiwKPXuaaKWGmWDo00VwfYvSiJ1i8sX0oX2KSkwKS9CsBVqyawpFGo4CT33Mb3jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq+bFH46; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq+bFH46"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29026523507so1356116a91.0
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708072481; x=1708677281; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOh4e66TLk/4cNIHb/8bydSWOeE5iv7yfVVR6oAmPyA=;
        b=Lq+bFH46hEQSN9DCht5N/fTUY1zbQUjHj4zbbkawRemQquj3VlYTkHoKjV1CP4pw5v
         0bsGQNOMxNT8FYI8OclkVejHO0+hjLJsV2KM7wQqZQtGJSqqKQnbXZjfNC3XpxoKzFHf
         SbB81a6RX8fnyZpha7cfrYIis3opYAZgzTwcagyY7BLVb+7ddqbJoyMQPCeaz+1y8O7Y
         eQ1ksZcmWFwHi6TMFxZN4a2mj3j5hnpJfoFXAs/TfW+ByRDN3ueFZffQDf7CrUhKHxA3
         1bUEDYsaqgFrRSMtiGG+p4es8p0Z53gJxJlHCeQksgTXC22K3INhd8CoJ4f1YZZeuOtY
         USDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708072481; x=1708677281;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOh4e66TLk/4cNIHb/8bydSWOeE5iv7yfVVR6oAmPyA=;
        b=AdIOUch2EbUb3/HCKUfLND2s1qMLPxeEgKSCqPeunypS1RNuN1zNvGSnjbHwmaL4oS
         zheCZVwxmEDUTH5PeetXW9J7WClEYQ2xSdOwCUsCWGPh7DDUxb1ZqpLyaQ2ytbRIab7X
         NNfD8OJBYzQDdGb16pLCimki7SAn9oWj48i2OxtSuvvROnFAt3VYUkrXaV3RZ37frFsH
         bM/QI0AnkfEsMkPwNVMgcMWZePD2NrfKrxOiw8HmOyjVSOKELGJykqWWmI0CrtFMfWQm
         B3qe/dQmH6zU4vVlZbU8nb0bmejv2YlxdDzdwZzSzgEBXaEPv0j7BU3ame4ULK3+Ktwc
         RdLQ==
X-Gm-Message-State: AOJu0Yw8OmxtmA7CaBgbHSp302DNndAEZErcCh0AnQBfla/vtE8nfXqF
	rM88Nxs1NP9DP59BjKzfV6m7VvMm5SGJhrtNDeM+6etuED1QJiEJTb+dsnY=
X-Google-Smtp-Source: AGHT+IEjEbimiCbNjodLVqJcLrmzPqFmviPA/mlKSzVVVnOHHu4pL66b0oAPvdekpmMj0rf8Xd+7TQ==
X-Received: by 2002:a17:90a:fa98:b0:297:2258:b54e with SMTP id cu24-20020a17090afa9800b002972258b54emr3952452pjb.11.1708072481187;
        Fri, 16 Feb 2024 00:34:41 -0800 (PST)
Received: from [127.0.0.1] ([52.234.26.89])
        by smtp.gmail.com with ESMTPSA id nd6-20020a17090b4cc600b002992844f7b7sm1510278pjb.54.2024.02.16.00.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 00:34:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
References:
 <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <a58f6f04-ce27-4796-9298-39fa6af8454b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 08:34:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7927632070

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ce45d1802870


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
