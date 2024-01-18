Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF16944D
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562694; cv=none; b=mlx3wbOAw1OPaXQWFYBMkUYJaKsF1B+qd5N2t0lMUUWCoCDt6fLJvAAitIyiYG6kCXstEadfWuq2mrOLfUL9yjTz8rq3a0HQk0w0zM6MxvBRwBp0jivH8ASWoyoSTfSqUZRG1j+PK6iWtI79s3F+sTxe+2m47NWzPrxyzORoH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562694; c=relaxed/simple;
	bh=/9YozPtqaSlM4yMtFcluk3qSOcsF/oawAsqc4fHZZL8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=MSit0ON1gwTuiFVUFuZsGFSiVA9oM3lvrske+EDT8or9aWFYhW0ukAqjt017sJSOe9YNeEebW0uLxRA+IZkqagKiUPN/cfaDbLpxlLpP6fwOUXoErLEcSpOuYMK6j+j4jh+7/wlcPR5BBSHkg3jKErfQBy3HuiQXIw+ZZi3prYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/QZayE2; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/QZayE2"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so10230631276.0
        for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 23:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705562692; x=1706167492; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyOvYo3IJED4l1k53xsyjP1hW5Uh/S1cCh+zVbJzuaY=;
        b=c/QZayE2pv5TmYSeXRen119vnp0Z9suvIlwKIk3JdJ/cKa9Q8SOwR8dfQd7CBIZQDO
         cNbWAQj1Bl/otfJmNNxVo6Z4sDQbiVDGL4I+gtIuNgypknjgyKExbksSkXMGGithfRx9
         ZHHuMvEPQ8oEtbZ7y74MIufRd/mNcPo1eYEgcw9b48WsvcELiDkLWjrQNdN62i6vohx0
         nFnMAsAG9PhCSB9rFI3m52mNayfnyknuo2r8ZigTa4goV2hg6/4Vtk3P+8wCUm+oI0xw
         yRQVLlHs3UhY3RDvDcjcAVwahVSmlz0SkzcZpazwu5Qe1CHLUBpr3S/IpKebTGLtuFY+
         qK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705562692; x=1706167492;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fyOvYo3IJED4l1k53xsyjP1hW5Uh/S1cCh+zVbJzuaY=;
        b=aa6+5bSMFee+EM6GnLUQbEi+o1/4GCJNe/AmaackRlAMIx5qMQZzNJiSfVGZJgeaXb
         PlaCW8BHY5J93cSDJLn8WJpb+XkJFiRC0hKNtJz/Hgi3cUNP7iiBobRf/YNf2/i7d2VY
         H/0Twd0Aw8LudEaLZYhuMijU0oNPzvWH8Payba5USscBtDuGfRIlDjbZIA+k1jK21Yln
         ugRqEMILi6T/pS7+fKRwW+xJHWmfHwWRYxzrFVzt7IJqH7hHJ+l5wVqxu8SoZZPMcJ4x
         2yCc5WiJ39yLzWSAGJSoyKWYZLF8t6JOR3P0wjHqMvizEASPszx8eMLsb0JmcgN0SPh7
         SGhA==
X-Gm-Message-State: AOJu0YxbN5mDfop6JbKpyPVf4KDbpHmhQEoIEGbIPq7RDRNmrwHi7YKD
	fmFr43l+JyO+PwqXqoCKkER0tkFwg+OHlNkyQG9HvO0BbwPTkugtP45AVyA=
X-Google-Smtp-Source: AGHT+IEjAvgqdv+mXxnZtEf94+kZ8ctT/SNDhEjf0A1W+NVNbOa5sABnGOwRQo5+1xzJmTlNizgy5w==
X-Received: by 2002:a25:c581:0:b0:dbd:8f9:a71 with SMTP id v123-20020a25c581000000b00dbd08f90a71mr304789ybe.28.1705562692404;
        Wed, 17 Jan 2024 23:24:52 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.39])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cdb11000000b00681746bbbb0sm1789890qvk.139.2024.01.17.23.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 23:24:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9281e7e64896c26a3d33ea78be3abe3041fe37d8.1705558030.git.tanggeliang@kylinos.cn>
References:
 <9281e7e64896c26a3d33ea78be3abe3041fe37d8.1705558030.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <96a99e65-86d6-c9e6-31b0-8f7e34a6102a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jan 2024 07:24:51 +0000
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
  - Unstable: 3 failed test(s): =
packetdrill_fastopen selftest_mptcp_join selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/act=
ions/runs/7566234667

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/08b2c98e8cef


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
