Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574D42501
	for <mptcp@lists.linux.dev>; Thu,  1 Jun 2023 17:37:45 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64d57cd373fso1864055b3a.1
        for <mptcp@lists.linux.dev>; Thu, 01 Jun 2023 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1685641065; x=1688233065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VaooKom1fpr+/gFLUK2ePWF2zVhCHZPLzAcFMttDEM=;
        b=MHSqsckRCpeDoAGkYMTNaUf8HXTi7i1vORvFkCxMTEUbOwF3hDPYiDc7fFQMPlAq2F
         cXQdYOZneqJDanRwrJGT5TiAw3lSbDh/dzwSjw6g4CmcRcd2jULq+fPI64PC3km0AJ8o
         2PjBMI8jyygfqWvpj/9HPpCKdpPk7v0MskmbjN6d7QCnag4DGEbtq3amlJSeDTwYc3zT
         c0cV9wX4QJgURi4YJnSboQbChb1aZWzL1hvpMQc5EufEqPm6+DIaJwCYZOZ6FWPWEgmi
         1vId6smHDNqp1/Et5J7vtutwuBFt7gM/c2cO7oARrjPxprOFoTUBsByAcCb0gBVMlPmH
         8rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641065; x=1688233065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VaooKom1fpr+/gFLUK2ePWF2zVhCHZPLzAcFMttDEM=;
        b=iv8+88RSOAoL/rie41L71/mv0W7mlZsPJeWusqq7LaHS8VWHG993+2fu3DwUSsCzUg
         /7iE7CkrDdU0fC6YSmyy77ZevJq0CZSGohtvApkjSdCFQMCXolXdKYGKSzDf+VQ4aAVZ
         gCgyfLdhHWsHXy2TeyXWQZyncW+N6s4k9RdWNbsL8VImugIX4JGeIHlWw8T0tfSgUQth
         kO3uEtcxsPlenBXVS4Yu3STYnPHcO3OGnhmJ5ywl7G02MUSp7MrDX2RJVWFhF8XvHqcu
         X/lwlpsVdOXd2x0tZkDxnKtWEdqtnGiGEm9Zs3UhM2xqJfVSDXBNvsmwGQlV+vsbbGpH
         PvNg==
X-Gm-Message-State: AC+VfDzHfyXjEv4LwAComJch9kdILTMynQrJpkbFndGAeq0pwNhLBDwL
	OtfAnpytpUt31VmDcTudPTpv9g==
X-Google-Smtp-Source: ACHHUZ7z6hqFz0/ybL9ukj5Ma2ElT9E2J0J2UDKTdWLYHsIJgV2YGGUXYubX2wob3APlALw7YS3Uvg==
X-Received: by 2002:a05:6a20:3d87:b0:104:1016:dd0e with SMTP id s7-20020a056a203d8700b001041016dd0emr3075210pzi.3.1685641064841;
        Thu, 01 Jun 2023 10:37:44 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s13-20020a65644d000000b0053fbacdaf59sm3139207pgv.69.2023.06.01.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:37:44 -0700 (PDT)
Date: Thu, 1 Jun 2023 10:37:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: skip printing "link become ready" v6
 msg
Message-ID: <20230601103742.71285cf1@hermes.local>
In-Reply-To: <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
References: <20230601-net-next-skip_print_link_becomes_ready-v1-1-c13e64c14095@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Jun 2023 16:34:36 +0200
Matthieu Baerts <matthieu.baerts@tessares.net> wrote:

> This following message is printed in the console each time a network
> device configured with an IPv6 addresses is ready to be used:
> 
>   ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
> 
> When netns are being extensively used -- e.g. by re-creating netns with
> veth to discuss with each other for testing purposes like mptcp_join.sh
> selftest does -- it generates a lot of messages: more than 700 when
> executing mptcp_join.sh with the latest version.

Don't add yet another network nerd knob.
Just change message from pr_info to pr_debug.
