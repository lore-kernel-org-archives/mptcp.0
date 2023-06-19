Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A517D2F2
	for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 14:42:29 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso3263067f8f.2
        for <mptcp@lists.linux.dev>; Mon, 19 Jun 2023 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687185747; x=1689777747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6epH37hdpG+43zHnm1jYAPdZwnsNsyegwEKE9/FA+rc=;
        b=pklYDm5xRYSW2AFNSWM+3VocxKr9BLg1Hr53FKkK9tKikvleoVDkWoGy0DGyvMtRhS
         1wf7MwFV/UENAd2a/dnHUPUgEEF4ffzQ5MJsDVu6iTkZIO5/NvnDLHHVrjYy9uOINf/2
         yaljpVx4+7G3iXza22CoRJTMXPNIc3nonETbQWvwiO86FNPUZ71BbOfSUiF21VGHrP1i
         /CwDxFubryo7T0HSuylB0Rx2jXGdIOjC/4gCT8rAHWk9IW7MHDaT+hL/gm+8w+Es61Dj
         sGgZgmpZaYX9DtUcG/vfOKZ73X9p6nDP1Fr/XcESVn3UbAr1ZSAheCCK5VCXYcQxmzof
         x5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185747; x=1689777747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6epH37hdpG+43zHnm1jYAPdZwnsNsyegwEKE9/FA+rc=;
        b=SbbCJTiMuhydMAy+DhUqBEG4KdQZsT3MvkwfzfZt+CjXYyn+Xn5XcMTYH+/QtgI2N1
         DcD585r3fpi8dZNtal4cQQm1Wavh9UJlRopJxlqbh8J2LNUn6/JNs12h4fGz0kfMJacB
         s8Yjyt1mUfSZO+IUPGIbyMILSPv60OhECpR/EEwFPRpJBIGN1OmqZH9dipjoHWdD1XWv
         ymW2YqAvx594sL/gRNTw+FGBvHPKZ8ZzieeZvEcP9cg1Gbbwoh1GsWemNLdgaFfjfq/T
         S8kpGMxU37c1UdQ2ZYqvdSMXAYwzXJCYOzluN6GJMTvLe9Yz777AhIz3oBQOCVkA/Snl
         HUkA==
X-Gm-Message-State: AC+VfDwQS7qLcYV6WGV9qaVSyQ7Vg0qQQpEVxQF3Wi05wq++10P5eMZN
	EcLru9L90QdJUemcJDwVVVvsYQ==
X-Google-Smtp-Source: ACHHUZ5GsLFi7Eftr+GWDtD5vjtCFIBvjRQh0Vm+yoQ+n8kb4HQsZW8B15VQxQMJV9e38t0hfcFPFA==
X-Received: by 2002:a5d:574c:0:b0:30f:d05f:debc with SMTP id q12-20020a5d574c000000b0030fd05fdebcmr7467466wrw.43.1687185747252;
        Mon, 19 Jun 2023 07:42:27 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t12-20020adfeb8c000000b0030ae6432504sm31705801wrn.38.2023.06.19.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:42:26 -0700 (PDT)
Date: Mon, 19 Jun 2023 16:42:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next] mptcp: Reorder fields in 'struct
 mptcp_pm_add_entry'
Message-ID: <ZJBpUaUoAmIPpU70@nanopsycho>
References: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>

Sun, Jun 18, 2023 at 11:46:46AM CEST, christophe.jaillet@wanadoo.fr wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct mptcp_pm_add_entry'
>from 136 to 128 bytes.
>
>It saves a few bytes of memory and is more cache-line friendly.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
