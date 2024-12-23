Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B818DF6D
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950342; cv=none; b=HfBefu+FICay6QIK8ZAY7mvI615hzwKSU6hCbmZZEhS3Cib8uiIsCDqL/sAJsCo5XHDlaVytHtAXQOegrJ5JDXZHKsxeTGq2UldUxf0ZQSVsnywrRVvDvQY2hmsy8QjWn43Dbk75cOcWTWtVg99L8RSgwt3hj4D8HwkMNNInIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950342; c=relaxed/simple;
	bh=wI9/F+jmQxNrSNkED4OLQHOcWMCvU/qfMia3fkJ19Ag=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=JCMl7c5DS6K8ZoNepQJSQQqTmFVoFRNniqITtwy3VAY6iZGm+23x6bacC4ca3dV7cD9OkzfVAvt4ayevnXJtTfL/hX9rRWCNyX+FyBEOZUnptl2lDNoPgsSTvDozZLIUMmCPie947P2+drnOGwVD8EYBQVJJ5aIEE+PMLDfq7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGvESsPR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGvESsPR"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467a17055e6so43298071cf.3
        for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734950340; x=1735555140; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVMJRwpKy+HC63qKmPRsEU6sMgJxThg1oplcB4oRZHo=;
        b=YGvESsPRemW8PFGSK6UUlx+1RlmArb5YidbTEHxstanfi1Z3Z99Ld7dFQe2Xo2zyga
         kRDD8RzQMipofDTkjenu7QIm5tCcChvRhhmjtl0SekSX70wIuci/swjWM2xAk1S0oJtg
         CuIjPKQxC2Q+tX0Q3NNtMtBTQH7PGlwuSmilYsimfADemE0E+bKm2AzGxshkanNiNfr6
         1pSGfbwecs9x9HaLHft8LaVk1BFZlSv+0j6Z9CTruo8Dg5lDXNoAA0IIPDb/GqeW+2fD
         Q2KKBRfnJGBab9KFatOT9v+CStkn4/e8QztgEvB+R8Ofmw4QwJUw+UtTQKZEeGXI5R0j
         VLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734950340; x=1735555140;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVMJRwpKy+HC63qKmPRsEU6sMgJxThg1oplcB4oRZHo=;
        b=sUHtfrR5jMLkDQMWGQYOhTcsBzsfEUnncQIna3b2DoCJT91G2oUeBsJCFDlUi784gQ
         biuUQSyWRwofvWtMkjiUm8mAfsYDXyoeQ5L163r1R1VVOivDq/V/XyxODR9mfel8efOe
         13PNUHPs2E5w3Y2mdpKusin2eSSoMc9jriobFKq016Rb8jfRIcM4nuhKxONSyYeJ/OwA
         hmvhsOphkQfyJmRiH7dEul0QlWYjuM+l4Z16vg+ZUYgATaHFk7oXdDtKGOEQ7JxLjmkx
         zf6sfVn9x3YNBolHs+GJyYGoakzJ3RLyjaX5oFwfKGPgtYntF9utyQys+lP2w4RwTU/0
         w19w==
X-Gm-Message-State: AOJu0YzYGPUTEqAQAMMD3actSBX9CzbxZLtnGFIWIm/4mGgNH6uB5YMz
	oqTqLWDgOtMw6q1tiPQDQTnNJuhuNt0wW9YIHeICibcn0Kab1rnNHKi7
X-Gm-Gg: ASbGnctUwaqSkCD0ai/DkA2syW+C12NwKIvMVIqd57KkQEggkTfwCCyhjHkZ4JTqjzK
	K78h6xd5X0xgKJ6uOPXqJIzrGhTSl1A8UUDtf6q5WLAmAOd+F0smGegRweyJQ7/wQrEtoqnZseQ
	tqv5JxsLZc0oVkHNZPyTr3NONptf9BV9e/vatRLOXpQBx9mgBmBr4HTC/WuFjAIlkhpzv0YCzgu
	X2r0w6HI6lvlRdIUIdjDmUwt+w5hiODHAdGwrKQkV2O/HRGZfqScTx48Yd95jvMEZs=
X-Google-Smtp-Source: AGHT+IHYps5xKtImnA8ey9cRkGWUTWwBoQEG2I6x/O/8G2yprXJZBGKtsBBR9D4W0ah56ZXHh3pFjQ==
X-Received: by 2002:a05:622a:287:b0:45d:82a0:5028 with SMTP id d75a77b69052e-46a4a8b879cmr188687761cf.1.1734950340056;
        Mon, 23 Dec 2024 02:39:00 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181373f6sm42678256d6.62.2024.12.23.02.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 02:38:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 00/10] use bpf_iter in bpf schedulers
Message-ID: <f660d27e-d20c-5ff2-e59f-dfe6203fb329@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2024 10:38:59 +0000
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
net-next/actions/runs/12465256771

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/dc=
de3004d226
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D920379

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
