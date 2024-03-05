Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A47D3FE
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622477; cv=none; b=XIhAHI2GMhEXdDSJVL6l1UhD3XoP3Tu8KDNqjCnOiTZkX+7cD9j5MVKrFlvwQr2HYpCnqa0dNHCqUrVJKBHAduHj+DQPeuI/elI9VL6us7l+IuAF0PrxJbHJqSz+BPWsGoIWOby2EMB9kfbVwX5rrcaE+eXtRuWYwtsiJhitWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622477; c=relaxed/simple;
	bh=XIbas1FjW16+SAmm919Hy+nr2Tfwutsyki+PyCX4M4M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SqqO6knZs49TEprExGxdTgO7vfp1OQXbF9m/V/LY2oae0HLxfkNWZtzmtIqIIc8vh6VFX7nCBulQEEDkDf0bYvd5j/j3c4+xBs30q40CKxL/d/ZL0BvQbkZRS8+3IeLxbLihZQr4hKLrHMLkHlOkMxHz3JiSypdYutoD6DPaB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvJl5jIP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvJl5jIP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6908b5037d5so414466d6.3
        for <mptcp@lists.linux.dev>; Mon, 04 Mar 2024 23:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709622475; x=1710227275; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxN539UvcoA4iUsTNGH16cqvtk4Rg6AVSKxumN9uPpQ=;
        b=jvJl5jIPiBLuRAoEgaR2H7v7zmmH9v3S2zQkMSRXK9g36NYtC+ImCWlZk3cg6nKeWL
         Fe1vReKhsJARs9CAW/0VGYbHeUypggPCZhonQIMtG/azDe4raQgu1JiYr19GzTf/DNUf
         yZfhBWlKk6d5Xs558uXip0o6V+TDNOcOuZWFYnAw+X9kQCl7iDtxy7IhHJ5vOm98mRa9
         VTfCmRww3CVfMYh29Ejrpz+2uVaVRu/zNHsyyXmLfgYLw2Nqc4FfI00rdVL1T2OHXzO5
         7Fd03yVqzj5LaZ0Y7HVPQGDZtS+72JMKmJ0jwBcXzJeGUtlKNrZ8ZwmGb1m3MrgnuZ5b
         QfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622475; x=1710227275;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxN539UvcoA4iUsTNGH16cqvtk4Rg6AVSKxumN9uPpQ=;
        b=bFRJcp8GWamMzYQX1ZJ2iMy7h/FrFO1gGjfd02EISOD89xZp5cH9526qd83/qX4E1v
         t+PAOuD6THJquivBvM8YQ/GqZvMtpRz8e+8Cw6NL4cO7Ajr66XWH+6iIlWmLVZn//DJA
         XcrFT6kuZAVx6tA26LHAgd2MGacM7iXogBrK7x0fndVJkLzPvcD/TcSyRvekzt2tPzJg
         Brc2VC7QpaF0NPnhx04MAmRFJobhOW5bAW7YxMKxVtjoWwYbofchuD4sJv11VCghszdX
         EeDxq249bSc3ZxNEEfJOCVTGjHh/8IRzh4xpOh55cybCuQY1ZzTvo4tFLDnS8WNm/vmr
         JHgw==
X-Gm-Message-State: AOJu0YzvDwdfvAraX03wstK+o9y3kQ/5rVMsD4NUdRpK+6R/rQk4n+VR
	vokNxBSp1YxrXbzg1etWXzZrnq//FyoBhKvDjLp2e5hdBSE0vSo1Yhb4Abk=
X-Google-Smtp-Source: AGHT+IHXeToM580/FKgsQjquOlNl9hFFiqJmhyE8UTBbqL3kvDNHbIBDD6rwoC6716uDXIXkSsfsFg==
X-Received: by 2002:a0c:ed34:0:b0:690:6645:9756 with SMTP id u20-20020a0ced34000000b0069066459756mr1032755qvq.45.1709622475005;
        Mon, 04 Mar 2024 23:07:55 -0800 (PST)
Received: from [127.0.0.1] ([20.97.189.23])
        by smtp.gmail.com with ESMTPSA id op29-20020a056214459d00b0068fa815b517sm5944621qvb.6.2024.03.04.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 23:07:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
References:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <c26d0a97-e29b-e858-cb14-6e08f893fa03@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 07:07:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6723624095186944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6723624095186944/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4524600839634944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4524600839634944/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e3e5f8571998


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
