Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126BA39DBC9
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789298662; cv=none; b=Rp8F+wZZ5KXkX83aaHH/U2otJ4/yD0tdIMFfBfQUxTak9x0dwBv5swPXO26G+gEATsx37k0Qzo/tlkDiHHR2JERYfKPiOcFCGPuZHLAjNnyt6atUIqfkre0Ml5HCLKlaEhl0hOyW03a2c/1wHd2dqNnDTt68wGDvv58j0/2No+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789298662; c=relaxed/simple;
	bh=QN5mHNmRM+l5kfudKUgGzkPCnov3j594iB7Fsf0aZA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=g4SfEoTWxECTo7hBu00GeatOBxSKdEWtZEmvIc8N6zmkw5/kpqKnEquMvvoijb97YyewhzisxEPyEhqKVbQTkFMAbDz8I5DfBEBEYhdxQ6C982M4cKWYQAPlDaMBBYsrKF1wqcwH7UHrjloXrxE1aRjgJDV0XDrTG/WqUrgDnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCoMNkuO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCoMNkuO"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-939b5ded99dso242042385a.2
        for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789298658; x=1789903458; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bM9gAf/ojJmyAhC3Na5VFm6IZGCX61gXx+1EIgLVbiE=;
        b=UCoMNkuOjRBN5JX8FoSQ1izn9a9cIbOq7T960uJLk2nnqu8IKlmFEI+BozpIDaK/ur
         GhG7Ov8kisugIhJF23dxIxmkQPc/bVS6AKgctSDd6p0wd5K5QD2qGpXbxXYHy2VF8EiP
         IoNkh3NfWcWNX86gKefm/i/oOzJm7VoZAFTd9axiUQVEKGRXVAZ3cxeXQx8VNRyk0e8a
         0soqO76rXCOKcunX79HJRjRUr+WJCJVhwIYP+i2XQEugDpkuaO9BaLQtaZT2B32N5MQz
         dg60ve8rd3xIMIw+Xp38ew1SEcS2RQAR7IcNlqVUzhoOzLRSbFlw7P/nv4HDqYCUVRzL
         yxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789298658; x=1789903458;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bM9gAf/ojJmyAhC3Na5VFm6IZGCX61gXx+1EIgLVbiE=;
        b=bqKSYlMoKHUNtWtNTWOZtmSei1uEEhWmNoum813GC7mOUEScyzGJUhXWhTcQCbLEYR
         yrMsEiRm1qub24PPdtYk8JCLzqfG35sy1x9aQFOswniGLjz4tDvYJD85dkrJJU1y/Yec
         h0j5Tw4jMGh7+JUsquQUEpirh+Sz06HVS3zZMLlIZCQwST2EuvTOhoahR7veu9e3vv3J
         xkzPyz5im6YMmQR4GuoX3bTqZEE9Ulolk8EcUsbbinct7/z1mvo9RULEBx/pSfUih1Ah
         DYfv0huNySlLUqW/udQQum0LLvCZOAJkdo0TknFTUMPNRXmg/Ter8M9sqqGzxvhR6YzT
         rQxA==
X-Gm-Message-State: AFuF++ka1vuzQXM9yaU+7ItYE7oY1l0qzW/yJhADfOmIhNb5tIYLhTNy
	kzylE4GbF1oYXwFUcj6A9o/vtE6wtb2q8jfsKqcb9CHHk+FsCz0gr+vAnFG0TsY=
X-Gm-Gg: AYBFou0EWo86iMGnNNAICXqK3iuuxH96BKsJl31zb17dsVeEHoefBpN5LALyXKcYS49
	cwY1v2GVl44874DWrVAXvrrbwsdqGvMZzi74yFZHx5LE932ilnOo/xtyUrouRDWybSKioGCgPz8
	vK4vkvl9EN39UawsDCvExtxRitS9z+HkeqLeGjMi29ZJ/1FZ1+qsqP0k0/orKxrutypLM0Of3uv
	uFLBpFx1tFi1V7i0t90LOKG2HGdzuRD48J1uc2nJEZdjDF44xD0xNbl32GzHZkLJJF4gEN2V9ve
	Ii7YNhaUNmC8HUUKQWMdPMh/8hWI2N5XrF8VlVzgleX9ixQQRD26SQLVzzODn2hdaAWfBTJcwqi
	8tcvbYYdyeCgQTRdXX0pPc3/5qw72jhoH3rYUgpQvUk2AurN7/oiJUf5XkhjKIq2ibP3afcLTwo
	pQJlv7L94R49sbhhOdQ2GDC3soMkYJrSv2FAA733n0cvGt3QAkgDTEyjl6+Y4jd1oloFtpAtX+F
	LwShEJoLTZl1A==
X-Received: by 2002:a05:620a:3f97:b0:936:cae5:8b38 with SMTP id af79cd13be357-939ea0431femr1685516385a.10.1789298658116;
        Sun, 13 Sep 2026 04:24:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.29.102])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f1dd527asm600178585a.16.2026.09.13.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 04:24:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 00/16] MPTCP sockmap support
Message-ID: <7d725fbe-154c-d2ff-0886-bbbecb62d749@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 11:24:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/34752281733

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/30=
f4301b3392
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1163753

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
