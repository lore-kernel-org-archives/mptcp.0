Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3A72
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 15:31:02 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id l26so7286853eda.10
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YSqpakqmmLgwyHVvD2eA/XbwZGaP61l/onwwegA43kI=;
        b=cEmK0PphwjGvgAaJHifUELcxDoPvg0UjSPQqHXteBCpWALqa+nhYziwTcrPOer1hbv
         N1avO+qcvKC01SSN0TtmE2vjuogjfSncIMYRUUqQn9UgGvLTkYbM22SGjZPERbggjasV
         54GOzv2SC4gn74jfp0YkGXc2QhkcdAPkSOpiXI7VCNc3pmxX641o/61ODDLroEUQy3dt
         f9zLzwMryhqw7+K4r5eU1dWRcDbBVObqiJmEUrCObacQhozO/Yh0QV1UfhVyXNXP4nTM
         wjhTEExxJwGb43u1CEbpGCJQYUD7DSTvEIAfUIdBVjUsvQaAga7HyxhB/tuhwW/fQJYP
         rz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YSqpakqmmLgwyHVvD2eA/XbwZGaP61l/onwwegA43kI=;
        b=sbA6nDeUeQDrqVsNuRw3ML1MtTly+9maEZsCiEyAN8agsQTjEmQkEpeLNW4HifUMis
         eFmc5vrRZ8bxmloyfJRkvpCRPm3LiK5PG89wrVYQdRyuKsqnBvWJzSlNsebZQrmR3S6w
         eVIJ6me8EOoXDjQOkw8JX5eS6XPdJS+sCK5goYJbQ8yA36WUUpNm7v5gUmPhJq0umlSV
         NixEQRQeTbA3fojPk3eCvApGTepM0E9DTU92nwGeyVTBj0EKwiK7lGcPgG/aC2IcIkW5
         bsC9xfwUdHYnHDd33bQr6TUYmttHW8Do8b4ncxGx3Ws4i+q32GgFNmkbjfzLYpLKhbCT
         yh2A==
X-Gm-Message-State: AOAM532PKjd+ujTozdtmbdLYJuF/0XiXIC9EN2OOg5S+ZP1SBRn3PwSI
	134BlMt4bdNRxY6MYPyTi3x6/Y8PNEzB/4/hckE=
X-Google-Smtp-Source: ABdhPJz2MynUk34zMo1HVyU+IVDE0bBGovqRCz1SY+3Z+PjxJwiSkoM4BMx2mRYAFQjUis9SGJx8bA==
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr220507edd.346.1626967859788;
        Thu, 22 Jul 2021 08:30:59 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:a2dc:f69d:fe16:9f4e])
        by smtp.gmail.com with ESMTPSA id j18sm9579549ejs.114.2021.07.22.08.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 08:30:59 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next 00/10] fullmesh path manager support
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <cover.1626877655.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8c0f9fd6-0a05-6b68-68a3-f458ea3baa8d@tessares.net>
Date: Thu, 22 Jul 2021 17:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1626877655.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/07/2021 16:31, Geliang Tang wrote:
> Implement the in-kernel fullmesh path manager like on the mptcp.org
> kernel.

Thank you for the series!

Do not hesitate to share architecture design if you are unsure before
writing a lot of code ;-)
(But if it is easier for you to share code, that's not an issue for me :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
