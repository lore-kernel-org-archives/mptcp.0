Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4E26A1AD
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688741; cv=none; b=tqu+dhmLRSfpnCPT2yMSOnY6cXXa2YY8yd1VZYIhSXQWNHZO0lcqWd01rozRIGmw+jMkqo0CVFdHJRqmMLXep2XcLc5zyDOYgYg75yhpMznW2budCRRgpCiGb7e/9PRRG7QyS2BO1V0K85fI5djI4A6K9HiTCinxanBl6jUPj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688741; c=relaxed/simple;
	bh=ZAm7JQ2wFcN8A8SboprTe2pTHSXh6AmnoiMY3yTTU38=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jyHC+NqmlY0zkU9JVvARCXK3R5h6B2OOJnXk/4VssHk2xVgnKmhILNBRqnv73NRe/JHoUdLDI9h36lfEp+dPFkDOtjBa6QLPfXHDe4a6IHCrzqjxHPPD55Y7u8GcgVImtmoJm1bE2F1sZ4Rrpr+Gx1I8hqzV80gwfaOICPciG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP87dTe5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP87dTe5"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47220d28138so19685051cf.3
        for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 12:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740688738; x=1741293538; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgrCfLkbdabs57w4ihhUSAEyToNzYbLycvgcF2spJoc=;
        b=MP87dTe5Q6gM+JGLhLP4Bc93T2ERf/lEpt7n3Qf+jaNEk9qLjvkEh01N31UeoXP/e+
         sK2t1Dslrn5+zpfGrSVFEPQjbOmjvUvSevc8BCCi57CPdcUEABVU0OvQVWvhT1gBz2Zx
         T6HMFDNBS0TZjb90u9GgQ2e9QHHeF3EkW6DuMs03SI3hqpiD8Z2dXX22vysdiE7u3jad
         z7w5esPjxO/n25BLFZe60rXnBFy8WbYwSuq3fOQkjm7xVZf1PsyfRexGueoYWQDOZMAr
         aqHd5YuK6VGM5u6UYBAw9z58S22PjiB6APhLvTUxrP1w7xGJG7sKYtBNMKUKQUmx3ZHd
         4A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688738; x=1741293538;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgrCfLkbdabs57w4ihhUSAEyToNzYbLycvgcF2spJoc=;
        b=PtmskOPdOjXrHwD4SXnXXqeo82rxcjba20kPv/+Ss7/8UXghsHwkXfhQPvqHUVUGb4
         MqdrHXVc0BzzGyT/au3b+F/Qh7okO4NMmUg+hxAGPBdezvf8V7qwS5o9XhpEfTHPzm77
         724mUWb9/m6LfRzzOYCN3ymkZvKKgqMDwSjyzoCbj5ymJ4WTrNaOzUNmw9HVm6JfCbOS
         yfE7inAOpb0pokqZsYcVEAqNZqq8ny91hGis12Js6KJydsOf9tRtbMDcop9iBRxqqHQ1
         Rc1LxX0FFcSOqktI3PGR6KDFEvjBrfdPwusGkq9dvudAuYns6VsWs4Tci9xTTleNP1/y
         Q79Q==
X-Gm-Message-State: AOJu0YwvphTDekXvr273zXpoqbHyAJ/9fZhINyLATmOnYr7qBWROUE26
	6KLTDF1dWobXLTGQvTLeS1nHgmM0qemcWYnyNZMjE9tqwZ2dZD4Y/STR
X-Gm-Gg: ASbGncuw6QPfkhD+8tVbcKVjhCv3VeSKlwQHIuiPBaMfkSxW2GFcFdjNBIal/sfQMQg
	QJ0Z6VS67kSCoVzkEOHA1b7rM6VH9qxUzLcJw5MpRbqW8lKCGpM9F+VtHL2T5KahdoCEZilnQH2
	RYiUq5kc7TeuWpcLSnXEGkYI9TuHhudd4iLPETkc2WT9Xcywm/3cc1JpGuegHrF1zdkj1cLgU8S
	M9R8DugjgEtY0Rr0TTh4OTjOtUQpzJg8jhYDL9H5UbGvuqThGA+4IGNyPowrNG9AmDLGQdgKZ/o
	y6YX1t3Eoo3fSDEHQWFtfGc0oe+P8YpOxjmbUyf7FQ==
X-Google-Smtp-Source: AGHT+IFfaQ+X5HL/B57guLUybDzY4MJwd8w0noppl+ZW4fE3Ech4dYah1lSqx7yDL/bYj/Kg9Y0Cpg==
X-Received: by 2002:a05:622a:1446:b0:472:a3c:be09 with SMTP id d75a77b69052e-474bc06a851mr7443311cf.21.1740688738435;
        Thu, 27 Feb 2025 12:38:58 -0800 (PST)
Received: from [127.0.0.1] ([172.200.199.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472409b48sm15106741cf.64.2025.02.27.12.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:38:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
Message-ID: <a4ec8328-ab85-afc7-1a85-1076e8a8c5e7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 20:38:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/13575269560

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/42=
3721784d18
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D938681

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
