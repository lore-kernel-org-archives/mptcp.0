Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217BE2A8D7
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649046; cv=none; b=XZ2WQtweSxIAl5FfKDDil8MGQK2LgZ5mwZ+AhyF1PVQRYPzZLw1dJCiHgLO6bHB3Pkdb8/qokhyGNwrd73ydxJY+j+6xFXbGuX+7AJLKUeQ5+19hBqMGcrSnjoLTLWVnPHDcjCmEG0r3xUCxduO1ERno7ZDN7scKo5P16ZNdGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649046; c=relaxed/simple;
	bh=VlfCJTqIp/NhSbU8TOC902GtpF371msUoVrdlF5aT7g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OKQWIxZ225ypOp3dNc6oOhtXGTlVdduR7ej4lfH2ks1AXk3/r6FyNlFik7sRrWie9TJEEGj/+B8EcjUapTPtd4nsAzthCZx4cIZYk4McEQbfKKNbdabILCC32b2uWSPj9P3I6xd4rZ+WSWJhreBrmMJZYKKxarjx7K0WOLyP8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/VH9FAQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/VH9FAQ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c35a23b378so46281026d6.2
        for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726649044; x=1727253844; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZXriX/q1Hv+WJQQuZzkvpunVjjo+f6V4Gjs5g7UrGk=;
        b=L/VH9FAQPAss8OaGeOiLkQdPdQeNsrKNMEE+Fk9S7YmHCISK02QshESe6xpFPmv+dr
         Ei+qSK/JjhWddKERvteC/tZ1MADWruF7TQhWfknPbo5YYTGclPhX2VIc0LzHfxFFLL22
         3TvxpkDqcE0j1VV0DyenTyq1VM0G4oxwIfjSxrHHJ4CHnr8LfEPHbj2lOkp1ycNFyq5t
         auyK4+3c6kM3MxpYIann4kI6anrwMt1IfVgDOUf+2y2C9YjjFgyKXlDqp+zTCaAjHWKO
         ybM0pFZBJBg8n747T2oVLd0Q8LqD8FVD9k9hZ5CLHAm9cV07qHprJyX4sxnelwX/Mkvo
         MpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726649044; x=1727253844;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LZXriX/q1Hv+WJQQuZzkvpunVjjo+f6V4Gjs5g7UrGk=;
        b=ZJvjK3cPW1xanJB8uon4jlb5WTcPBbYkBq8HhWDSFK0UkZ5eoczf8Fnqo9osQNvm2L
         +7jw51RhwfW9mnC9f80INKL/vzwbCX45edOjyNwHY59h0G6NlSl37HK2M+3HYsmU2fqD
         qo45dfw9VkPWTujS+gXuL61Yb5KVqpvwBfVwOzaoRExyu1wtZALOc5XY7fK4dzxGVgu6
         g4ZOCcb6PUi/x4tN+8fYv/wVJrKG6uA+mnUnfJgQMjZaviYfMniUgUdA4VqpednrQzax
         vxvY7fXQ8I6FI6uLTqSCZIkw3irYxZRh78a1FlodpZHx6yag2H4ZyOzA2jdsFtvBqc1/
         suyQ==
X-Gm-Message-State: AOJu0YzltbQCmTH81PanDhzeTVqSRNqYOdd+nVcORn3O2ZddlCHOXi2l
	gmeX4wuBQlYPgwIYcnGUc5YqNe+VGbnNKGmYk6Tfv2RP0DpAffAYdIdT
X-Google-Smtp-Source: AGHT+IHQlhMUNtsHY55rJ/0ybMJoSoa2ZXb5WlgnByxluoRsjBmn1yhoHtxzg38vxAkIsg22B7NzLA==
X-Received: by 2002:a05:6214:5c02:b0:6c5:3122:ffac with SMTP id 6a1803df08f44-6c57358f596mr221370276d6.45.1726649043899;
        Wed, 18 Sep 2024 01:44:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.241.93.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c7d76fdsm42095176d6.140.2024.09.18.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:44:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/6=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v6=22?=
Message-ID: <2ee4eff9-64d6-a64f-2a6b-21ba7d6d95b5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Sep 2024 08:44:02 +0000
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
net-next/actions/runs/10918596257

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a9=
28a1640a28
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D891102

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
