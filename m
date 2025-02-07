Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754531DE2A7
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925844; cv=none; b=pEo+luyH+kAfQzT0/CO9JQD3te/+pZgJuo9kasxKIlFrCyqTHk8pI0xw/Z6NLqcdQpR1RcIRAo7z719IkIum/bapcmMmRehDbqd6WuwGg2W1Mk4pSWa4kwQV6/+/UMAfnJudBMvjqBotcCzGtkNMZw3WCtgxi6U7pVXfKydCe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925844; c=relaxed/simple;
	bh=5rsAKRvtsox64QPziosRZPk8PM14qCFRPSKWTFXY3kw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=b/vdEbys8FIyDGi6Dk+UMnc43zC8fwlKUQ2NPTRQFPN4DczcdenEA39JbedgBVitR0CY+PyqFZYEIeR3fZdWbhe6HPxKko6HbQMzrCOmjmi8nvaoHieAqxLMlNw1sleZXsuFYmRkZES3JJ18jOQUeRZPdOmjwXknExIMPsqQLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADO+PBMs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADO+PBMs"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6f75f61f9so283083685a.0
        for <mptcp@lists.linux.dev>; Fri, 07 Feb 2025 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738925842; x=1739530642; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIPQDdAaq3IZ9PUAVABIkB4/zWg1i80tDlPay2BCgoo=;
        b=ADO+PBMsXSZdk5e97eOyDOM29ZwciT1V2t35+tquhjM5BPQPbaG/pkN2kf409bXHmW
         UY92Uqu09M5WXBBrhBnIFKInLwZjpYJD2se6z1/ZHW62FRYpUdhvIpPfW6OjAxx27MNJ
         imRbfhLTLQaa5ebYOTp1akoJmbJADuuJeJhBZM0HiqyoNxIRmoSgFepI7LuhPA3HEslf
         7Q8dwZu3zwFqOkoEpe9joKbMhX4HXtm7cM0Na+YxObK0L2M6nHqXfZkyoxDzOS8KgLnW
         IoBgyLzFjNKJHWcu/nYCBoOb5e1PthRXMBW7OF1ZEVMb6xi1TeAZVJ59sJVqKq3JYTzF
         PadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738925842; x=1739530642;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIPQDdAaq3IZ9PUAVABIkB4/zWg1i80tDlPay2BCgoo=;
        b=u1Zw2RLzN0ovkPNmPzuPda5ijuUIHBqTxdP5vecbXDaun7w35BGMhol4V7s02AyOvY
         a34iKpoeBLFkl9/A0KNBpSdGXKBjampY9HLWrOKEYIV/9NOb0QWpeOxAVTbXPH3NTKnV
         9V+zvrh9j91CBI97csvsCTo5DORaW3LDK99KicRVvsrOMrvJ2iZyKvTgIKTl8XVPtpyH
         DFLAvwOmqfR2bvrOzDIotbflecIWF+ZA11sPPlVfdSBgcXU/sWKSxSoRwguumr23hy+v
         geSLPCWXUyc2zAYVx5q8zltx6EiutmElNiaafExWDyo+Guwl9mINyQIuJnqeIxA9F39p
         JrAQ==
X-Gm-Message-State: AOJu0Yxs1ptyNXfSOmf91jAzZKESPWQw3WW1WdjDiox8AtC2Vp5o+rLu
	6RNcH8F35clsaehyAAGx+XLzTVu+Lec2x+eCorGQ2rwredKFlL5wUU+61Cw=
X-Gm-Gg: ASbGncvin/U5ppaQVuSbA6WrJvxJbH5MD+CDDFkaRxJ2VnkGIkVig3AMFNZr4mx+wtn
	ZRbVrtoMMguXFjcbIPcDEKgj9kD0HlSCjZ+CQ2q+9H/XAvAy23VAqiVMBTRLLxLjZpIhsglRttL
	hb++Ze5mani+0rT3JMBw4WvZRF7RSAOTUvCHBKmDtzct9zrxXsJu+y1BqdBE9ZrVD4x+oeFiNzG
	dNP/C8/QCBEnM+86dWNhxA5L6gPijxRVHFGmwmnCS0bNujXwtBFvEJ2GSJM55xk9TIIXhG3fxu5
	6vwDGxo/1I3Dbvw/g7PEycXS7hLcpg==
X-Google-Smtp-Source: AGHT+IHq82mLheEbYPRZjDqFaHeow865MvC/eM//UqFdnwPePRm0pvBaLJlPc6z+ZIZfAAAbCTJb/A==
X-Received: by 2002:a05:620a:bd5:b0:7be:3d2f:16fc with SMTP id af79cd13be357-7c047c4ae9bmr284769685a.51.1738925842123;
        Fri, 07 Feb 2025 02:57:22 -0800 (PST)
Received: from [127.0.0.1] ([20.102.199.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e13bc5sm173266885a.59.2025.02.07.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 02:57:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738924875.git.tanggeliang@kylinos.cn>
References: <cover.1738924875.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/5] BPF path manager, part 5
Message-ID: <60c5b46b-3ce8-89b2-351a-ea6cf066d259@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Feb 2025 10:57:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/13198356170

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/50=
5f7739b1c8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D931539

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
