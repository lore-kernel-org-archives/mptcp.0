Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC118BFC
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314293; cv=none; b=qc8KRtaP1wkl8qHylOCa6DTbu2+DZAFlF6lqE7ndtB5XuOFDPC3bykX2YrRYBpm3VRBIOM5F2A8/R62T5t4uxkQSk3PQOc2SK78otacCmhQaqPZNiLYhd/sLLQ88vZpBm/QokOTKKwLa37XGUSBV0hfY5PJnJsY+FOMD/NY5ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314293; c=relaxed/simple;
	bh=3YvU3gUb6sSqMW3BgLvhg60oYTt9kUGE5zJxU3sU7kY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Gpf9jYz/BgSRnNUSLh/bWSy3d+SImDrTq404KOn4FrXbdaIi70UfNnY/CoN5mKKdhh6h9hzvnu+vD6ltcWa/NY5lK0VGwwBv2W1mHuXvar1aX+9uOyaB7oo2KlyPOe5zJi+J485hizRZEtet/i8CCTvXB+z8NFNyly4806yLtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1xn/rF0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1xn/rF0"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-787ef8b194dso256867485a.1
        for <mptcp@lists.linux.dev>; Fri, 01 Mar 2024 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709314291; x=1709919091; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCf6vPIko9sXfzUYuTlhCDB8k317Iu0N+sGeCudknnM=;
        b=R1xn/rF02oOcixiOItR3ro34v2c3KqHg7w7d04mBlGmRxw8JyalTktBA/rkDFUcQef
         f7jxgFlvucVuksYBEE4Sk4JJcQpXX2/PrmnU/hjGT/5NGbgaTt4rClz2SeACeNSWM/EK
         H0/vKAFwBvHLw08kIaggxbHi1cYSd050jJ1XwfCHecPaLst+w6J/WH/xoHmLB2XEWFE/
         JRBuTXN0TUieCwdvOtFXkDY5zOEFvAom20TTrtDauqbbJiNlURNG1wAEtxjUatwBIbfO
         hJYHMa8Y6V3BKXV94XLNUUp8zaAgpM8BpfubZcZouUVUM5Pt0aeXMbyJMSj+KUHNfhZh
         DWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314291; x=1709919091;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCf6vPIko9sXfzUYuTlhCDB8k317Iu0N+sGeCudknnM=;
        b=DVP7aZOwuP5zd/93fbERc5kiEdYVmeBHRXtFztGjVqkLhe8ii553Iz8+0npVkCGxNJ
         nqOolRMAh5GSByE2pejEiS3xNcrmwTzRMwg2zyuuR3UzY9N/jrCvtwMENnyY05Bi/snD
         B8caa6GKcb+jJ5ZPOx7NavQmDzek1k6Ggi12nPbzDzYcmlECiV4Y4TrRxLSVcGMRAxsQ
         MDXflRx7xM5Qbue8oAmVyMlXqdwm7yikk4DzjDGSz1HLbzGE7NCeG2eTHPSbXh6AJuXf
         gJW26vhEb1mSye+ioUIm6to63PIOcjIwFuUdh3uJRctN+dEIv59yX3LagyTuUiRrV3hX
         iYZw==
X-Gm-Message-State: AOJu0YwGw4JN1GjCsATP3TbuEdW/PbAL1xtMJlFSVu5M/9QMAPdA03PG
	qzATC2eEJIeEpWH46aUUqkmm/8FkjfEXmS5P5ynyjYBqbTwMFc0=
X-Google-Smtp-Source: AGHT+IG6+zPryH3VYJNKsEpDB3T4VnrYB4pG1Z9p9gZ5iXGIt2Le73V7pVnnSXM2lthOwpRxOTu+Vg==
X-Received: by 2002:a05:620a:2a0c:b0:787:debf:c584 with SMTP id o12-20020a05620a2a0c00b00787debfc584mr8475670qkp.1.1709314291035;
        Fri, 01 Mar 2024 09:31:31 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.65])
        by smtp.gmail.com with ESMTPSA id z23-20020a05620a08d700b00785d4d5768bsm1818630qkz.11.2024.03.01.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:31:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240301163846.1370114-2-matttbe@kernel.org>
References: <20240301163846.1370114-2-matttbe@kernel.org>
Subject: Re: selftests: mptcp: diag: avoid extra waiting: Tests Results
Message-ID: <c0ccd0d2-898f-faee-f2bf-0b380dfd87eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Mar 2024 17:31:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8114524834

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4ee0d83081ea


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
