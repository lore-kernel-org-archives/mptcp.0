Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE632D78A
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938862; cv=none; b=HW126CwIj+ZmHeCgIwmk93eRtJbVyR+lPWqO5idrZX5h+0MjTBVw0k40VMThcPS4c7rQxFKDXIE1fR8pPNckYyeOcVUFTJmWa6dvDX4Thsqi1u+FWCCQepuI/Ls7uk++aD0UMZgubbscBUyRy5zjvNp8cN/8dFPLYMKDzabj9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938862; c=relaxed/simple;
	bh=QZFLoJUVMncZ0HnlzkiD1vX4hY9P2f7EaiwJk/X4PGQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=F247D4iht4P7nlhOdOFK5F7xxZsvqzpwKKSWiPgN7ut/L09o4LEqN8Wini+EcTUROEq4eEPQk8KPD4gHnTxCG2rtQho1/FnohtYW8ZFlqvfrKOkBU4fSpAAg+1s6pBfEzqT+ctB6bOqx06+yL2mGOmwqK3ko3TbUwhU+TSta13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF+/vNRM; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF+/vNRM"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42e63a658e1so5211561cf.3
        for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 01:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708938860; x=1709543660; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPHQfJcjlxJbPkHRR8Zv+3j2RcyIvJdW4tfq3e98Q/I=;
        b=kF+/vNRM0gTLyxxGkIFeQK6J4ZccOeKfVTRVyMNiDvXkDJcjxWt+yp0UNlddLJU4m/
         2FpK4NAIWDjDCwp2wis9ObpvPaQQW2ab0OtdV4aEbl1jlhFsL9HRcNTba20hQu2fJLLo
         1DV/fa4DjLXvjmavfQnx2lNWlppd6MN5bUU3g1hOcmFPEI4qHpQtEAXSRbyf4LsBAX0Y
         WyYW44Ac4FfuXb22CWE7DXnw16GLDtSfrgQ+tNbCO8L6AMWgArxdfOQddvQ6uyYGIOFc
         l1eW+d97GteN+9NtPLpUhwFL1kGn0YyaoXSsI/7VOmZcUhOuw+X+16dW5ZdU2g4rMDlB
         jdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938860; x=1709543660;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPHQfJcjlxJbPkHRR8Zv+3j2RcyIvJdW4tfq3e98Q/I=;
        b=OQ+v5ftrZpTXf/nHYE+jLLir/AueFNCUjw35vWm6LH/RMx0cp9W2vOenYJTMSDd9mr
         yIdWC6XI7J9FPuIDg4zXRPjx47qf0dHTbx73TzMVwacQVUaLWNE0HVCqpHQFFH8f5Wga
         tzSlr7RwCzUXEf57/YqH5ZrCYITLRXv9HrOa+l7vtxPMIwmZycJBbjIU4Ir/5rzngQsY
         9C8iK9/ZuPf1mTq8K7lKUynONITLnZEsQmzqwgSncA/MkHoc6Xfri7aEQAnMZlVw3H+/
         tsR75J2XNhuyAuBc6gn7qeouKidix16xyeSkUEPohTH5zp8mflHsnTPQQaFdgXDXFH5c
         iQlw==
X-Gm-Message-State: AOJu0YzE0A23nljOFTXsKQOvkeo+yodPMs8WgrpJtdwARM84gtFJl9v5
	0wUduthMbM6ajA5R6yxUMYnKe5aK9gws2AkjB5HoPVJsxLW89Co2VjnuCxx6yw==
X-Google-Smtp-Source: AGHT+IFTE1WPLUu2N2UQqdmHF4qaHW5eINzDLHulgTKlMXWg3HS7yuuXgmlHyr8nUPT2HwG2sTXmAw==
X-Received: by 2002:ac8:584e:0:b0:42e:7f3f:ad4 with SMTP id h14-20020ac8584e000000b0042e7f3f0ad4mr3528172qth.8.1708938859641;
        Mon, 26 Feb 2024 01:14:19 -0800 (PST)
Received: from [127.0.0.1] ([20.57.13.243])
        by smtp.gmail.com with ESMTPSA id l18-20020ac848d2000000b0042e44960c15sm2248593qtr.52.2024.02.26.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:14:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <30f47153371ef19d5f832b3b2df4e6bf70955c1d.1708935196.git.tanggeliang@kylinos.cn>
References:
 <30f47153371ef19d5f832b3b2df4e6bf70955c1d.1708935196.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL: Tests
 Results
Message-ID: <a72d2212-4f62-d1ef-8e5f-fe868ca620be@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Feb 2024 09:14:18 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8045893025

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4cc3852a3605


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
