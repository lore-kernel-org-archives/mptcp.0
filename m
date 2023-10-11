Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3112B91
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tessares.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tessares.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares.net header.i=@tessares.net header.b="YEOOVLss"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso539197a12.3
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 23:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1697007490; x=1697612290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQEo6A7NGi9MDKHUbZsg2wbhZm8/4Gznq0rl2jwOyvU=;
        b=YEOOVLssCL+w2FNwjsHvdXzgDLX5ZhmmZSkF8sq3X+d1glwK5jRpEwt4DDHT0ISEXQ
         /0xYODEfKL1RE22Sv/VEb+e2yQEcL4mxFUrR6tTxr76thj/YpkgAshY8aenQJiKRFWPq
         k06xd+vWPM3YZsHKUKEzeqQ4fSVdG/8H0qTAK0zLFg/XwS1pkKnYxgnDQ+cdvhLQm/pZ
         7aiEcPrd1cFfuuJdh8mx4jFHsXIs81olwTURSLye4DvcMmAzSmxdRMmvB8/O4dgb7Sy8
         7e+4T6Y39jmMb9x0s9wF8Qlsxj/TXMId7h3ZL6IpCul/QB4t+13++neY8ULDfLXDDopO
         ANDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697007490; x=1697612290;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQEo6A7NGi9MDKHUbZsg2wbhZm8/4Gznq0rl2jwOyvU=;
        b=IsdgeEBlTEarydH189+stDdjI/qXeKos/+mI4iglgntwoBx8mEDwkpwyQd4L86G0jR
         gpx8VpIILqsz6kuZN8M3weTPJaNFZksdI3g+Z2yWjl9n9eQ81iIqzwJFVqJz7Pk2J4T2
         68KkmGkEOq6Z1ddjwiAqK0BDqod9V3XUYuxrP6WVJzHw0aLOGEtZjIa7mmtSS1kZHqP+
         /axB4QXeZ97e/zE53+Wy2n0XATDzIte4JACTM6mid4ESaERkHLAc1CXRgSBJ7e16D8gI
         JURAh6yRYg7N11zGJ9pZC5zqH6xeJ0WkvckkfvCTb7mE3QH/MGXTAF2q8P/mKbmSiR4z
         xwKg==
X-Gm-Message-State: AOJu0YwGCs6Ac/Ug506Ca3ZuvFPhrrJUTQmp/+1N5jQdwrCb0sxviPts
	/bJdxTfMAZW6S1bw84spY+FU2A==
X-Google-Smtp-Source: AGHT+IE33I6du8aVxPvervdH59M7yTTlQX8lz382ENKf0/EiLhWeGHrTMOECiU+bxSb7bftDg8NyiA==
X-Received: by 2002:aa7:d6d8:0:b0:530:46c:8e36 with SMTP id x24-20020aa7d6d8000000b00530046c8e36mr16481503edr.17.1697007489811;
        Tue, 10 Oct 2023 23:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([194.110.115.78])
        by smtp.gmail.com with ESMTPSA id n19-20020a056402515300b0053495596f42sm8549462edd.30.2023.10.10.23.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 23:58:09 -0700 (PDT)
Date: Wed, 11 Oct 2023 08:58:09 +0200 (GMT+02:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Message-ID: <ecb363f2-0343-4126-83a2-2ef043e0a3d4@tessares.net>
In-Reply-To: <cfa0382eb429ef762c6c862c2cd7c6d4dc6d2441.1697006323.git.geliang.tang@suse.com>
References: <cfa0382eb429ef762c6c862c2cd7c6d4dc6d2441.1697006323.git.geliang.tang@suse.com>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: avoid resetting when
 another subflow available"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <ecb363f2-0343-4126-83a2-2ef043e0a3d4@tessares.net>

Hi Geliang,

11 Oct 2023 08:38:05 Geliang Tang <geliang.tang@suse.com>:

> Invoke mptcp_subflow_shutdown() as Paolo suggested.

Thank you for the new version.

I didn't review it yet but do you mind sending the whole series to have the CI validating it? Here it looks important to do that. Feel free to add in your series my two patches I sent yesterday.

Squash-to patches for series that have not been applied yet are fine to fix comments and small details but it should be limited to that because most of the time, the CI cannot exercise them.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
