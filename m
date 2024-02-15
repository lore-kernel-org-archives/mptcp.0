Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D712AAEE
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994690; cv=none; b=jBzh1Iiy7aKvjcgUDIhel/7YKZ09MWNnAg81RRhEhjqQRpYm7o5p+npKXE71j0vT1vnssemcenHZsf9kTLqtMn0lIGfTGJwk+o8MNrTRglL3BS20uR+vjFxepscvdFRQ3X5V5WOPPB5/eyyN/J6XjHErD3tB9HUQ5y3vknTRBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994690; c=relaxed/simple;
	bh=iYuUnZcLsGW4Ro85OdfH9PQ0gWowf3rw3dMVePOKXOQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sT5LFuDDy7wJo28ePRtcE/PiimZOOslH3a6u8Yiw3W1kppp8t7OuqmQLZwC2ClgOXJ3nQRP6G2mkqPvUtFpg8tyhV95idnLmqlQtuZIzMwMe+I0EzTOenTVnt9ceqRIit+Vgb8M4Gk3Hnb2cIam7hhc7SeFGMJHjMjVYQKXFxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z936LNCQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z936LNCQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7872bc61fcdso31593585a.2
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 02:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707994688; x=1708599488; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ce0Zut+YfdTwvzIbjGDrf0DxTUoWPw7/8/UQm24K9o=;
        b=Z936LNCQteeFauQJML/Z8AUyxaCw6gdIYE76IKm4Uwj1a9m/Xm+vCvuDxAPNQREvyk
         GoWv55Q/VYD3gp30GrlvrPWx1xKqPjbU/gTQC9fc8fXhNVjTdlPGqk/DLywXOFpolvMX
         32LMhwheV586ItvbTaakkiUCuntKOPBDQKdgG+aVBr4eMvwrWEH8Io5IloodFcIGYfTg
         8U0AYoU5IDWtRcrSXqLtt3ZKbM4l4oK0quwl83zaQ8Ik5QX4EsMsY54FQDNitPIK+KKe
         SDfhxHodDNjseDuAMkhHmg/qIPam9AZY0kjbfa2qD2FwSKDdwinIJ4orea/GGLQgdUOk
         p4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994688; x=1708599488;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ce0Zut+YfdTwvzIbjGDrf0DxTUoWPw7/8/UQm24K9o=;
        b=HCdOwIolTDy1EOY38WqKFSFtbbI2+YZhcH3WIOCuW4PaS1ASqJF0vASAuknRaSQxoc
         EzMHf5wJ+d6J780klqZVnzFyf/osHbEvmjE8hbjWEAbaKBmNrewIW1gADdEca8iPUKmr
         F4TQjRhSBFyVPVjmXuh/qaUITMa8n2GLlJDtd7t5s9ROJ6cnyLWGMhJub5AYgJUToKm3
         7r7F26Gz09AV4PUogAIzVOU1tWUSKUWnyo3j8if3HHQBjRbsKA8tRMiONh3Y95zoiYKg
         cpYueF+peW5TDkIbVxpiaCxPPiRFcMHsM91R9FvCJ9rX7EbRtAfHGolZxli1s3O6z/Q3
         /HVg==
X-Gm-Message-State: AOJu0Yy7TlbJz3QFZEzPkb0IGbfyVMzVof3EM73ZsjDOCLO2Elr9GxFS
	nGKiUaka6ivEXdePKZI13yKxof1QpUaQ+aQO8o8wVTswq0VzMPU=
X-Google-Smtp-Source: AGHT+IHh3DWOGqfCVo9JxgLKOTpdR3WQEXzOmP3l1EqhTgsoBQCPlQbv7ubXqQy/U6H9p9t1PNK6Ag==
X-Received: by 2002:ac8:5a53:0:b0:42c:2990:67f with SMTP id o19-20020ac85a53000000b0042c2990067fmr1838559qta.28.1707994688117;
        Thu, 15 Feb 2024 02:58:08 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.151])
        by smtp.gmail.com with ESMTPSA id 16-20020ac85710000000b0042c4e191660sm462464qtw.49.2024.02.15.02.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 02:58:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <970ce17f-2ba1-4e55-d483-086eede37a59@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 10:58:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7914279679

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4b23a08aba91


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
