Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182D71
	for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 16:39:56 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id n2so53908058ejy.7
        for <mptcp@lists.linux.dev>; Mon, 19 Apr 2021 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:cc:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+ZzwG3gFl6zlZZzsIQfdnTzVRpUMJtg2gHom/APKiI=;
        b=FBHctN+K0njJ1nOXPltQ6wskuaWSVCt/IMXITHBAnDj0g7GDMZQcKBiH/XzjmnXFdY
         LAbte+o+kI71/+iPNryVnO6jvxLnHBU39RVY0VKA8GSLHJmJ1Fuof49GJ0h5/UHURcjI
         AHuSQhCLRyNF1ToThvMyBJYkRpjgUxP1E7OSnngVmH22z+Igm1lpSrMcUcKtBCagJw1I
         N59O1g7agnT1hBeIVQZ9D3hxmmL+DLChOZ9h8/6cuaa63RJ9h3T5LqLsOwgXDRO8GeDp
         CuYhO4DmTpIrQVIO3pp/ys0ZvXnSocwZOrrMxNCbP2HNRTvP+E47wAsPmJ17ubMrUJGN
         czaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+ZzwG3gFl6zlZZzsIQfdnTzVRpUMJtg2gHom/APKiI=;
        b=Luvzvr5Aw4sc2ejgwC11FPWlww3UvXdESluJ/VrrWr2Q2KZ164fCIFNt/eEc4hHPSh
         GoJv1oTzX+2JHQtrV6K5Ucq8B4dqLfcALC6E6TfgBEmCDm9vlhXmsF2C9JKCmeI0l9oO
         yQuWaFoNnTx4OCqB4iR9PNh4QOK+u2crjiK1gurky8scKJfXIsZezdvL+AwAVAK5wPMU
         e7NdHzrqhZqxCeW7tKUuS4sUpXOntc5Z9sDO7IOMaqplEOFAyBHTdhgYpADR0H3RP2oN
         koalTOBMqcReetn3owZL3/gzVv8XMlI3SY8IL2/8OLVCbMAXB0dZjZRMQEAVI9tQ9o7b
         I60g==
X-Gm-Message-State: AOAM530ng9xW2BVJSY8RLajipKaCPWL9myhfqu+tvAZyL5It/ig5O7rQ
	cHVYAP37viYA2MoBAwnxhh7YtFtQQ8Lgy9R3
X-Google-Smtp-Source: ABdhPJwcnSh53cnuetidwm1qT6qPU2IeWrO9GK00tnvdjKk3Xj7FYDhxQZnXYbDBjYzOBdZRc3Powg==
X-Received: by 2002:a17:906:349b:: with SMTP id g27mr22682486ejb.306.1618850394985;
        Mon, 19 Apr 2021 09:39:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([185.156.172.168])
        by smtp.gmail.com with ESMTPSA id dc24sm4510179ejb.123.2021.04.19.09.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 09:39:54 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1618502178.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/3] mptcp: improve MSG_* flags handling
Message-ID: <1c462183-9c35-ead2-bc6a-0777ee547a97@tessares.net>
Date: Mon, 19 Apr 2021 18:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1618502178.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 15/04/2021 18:02, Paolo Abeni wrote:
> The current handling is a bit fuzzy. Sometimes we silently ignore,
> sometimes we bail on unsupported even on no-op ones.
> 
> Let's silently provide a provide a reasonable implementation or 
> bail (currently only for MSG_FASTOPEN) for the flags with user-visible
> side effects. Finally silently ignore the unsupported flags with no
> user visible side effects.

Thank you for the patches and the review!

Applied in our tree with Mat's RvB tags, without a spelling mistake and
a switch from ENOTSUPP to EOPNOTSUPP:

- 79f8f01a2fbe: mptcp: implement dummy MSG_ERRQUEUE support



- 5ea72f542f69: mptcp: implement MSG_TRUNC support



- faf109acd959: mptcp: ignore unsupported msg flags



- Results: 8da9d3d6f081..0bc569d1592d

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
