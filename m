Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AC168
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 16:25:34 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id b7so9859713edd.6
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EUDYBS/aXYnkYRstw2RlwXT6VxiEz8KXD/NaqOy0+zk=;
        b=HwQYcZjXyEKYWjMkmMprHRuGYPAjGv2CjRiStoLLY2TMYYxAIC8/ls0T6Ypfrv/mM8
         u5En7Cm405aKmZuIhxxM8Rc/DDjpKpOkZXapP1EghRAJaPr1zxTfgqtLJXC3NWwEGvnj
         oonf4NN0SrRwIIOhwSERJKlQCpF+UwqQ2Bdv5IpcXcrUVF8EqVz/rZgYfnUAjEIUWEBs
         5qeJduW+gw8msc++VPKGlXAfsqLg324Pfn3v46F9PrnioPLd3wtvKqAyj4/xilsGRlZO
         VFKMHVPVjjcaE14y5ey/Ny2uK5nb2Pwphy5JGc8F7OW1SqD4UZfN4ySLRKnS/QIxR7Vo
         MZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EUDYBS/aXYnkYRstw2RlwXT6VxiEz8KXD/NaqOy0+zk=;
        b=XZ69n/UcCz6swuOqJD2xH5LrnZmuF5ufX8T6fhI/Ywd8QN2A8MW7oNksxxjZUcCTU4
         J3ymqM4bR22MWaC87YofFKcMjZospy6+vWvYuqgaz9cr7qdZzFGTRn3pF3syKCR8kSGO
         FPhBZMGle5FtnMVNSn64U4PtnhEiOHbRcct1EWR8/lBHN+wtB0HSX7NJWKA1n5uQRYin
         aAUhMiDGYxK+y71CWBvEAp7mKg6HfSnAucr0WCrowKxJ/LiESmJA3dkCB36uq2N6Aldm
         tE6fKgunsAkqrxcu+RkK4cWEPHow1usS8Y1ah+rzYNMAcajXA/aSlur34hb3UjSy5FaG
         0Faw==
X-Gm-Message-State: AOAM5332JhIKdi59WDaRSaueaymq98nJ5g/JJ+fiTAIp1vzJEdMC3B8w
	NETLOMi+sE3hXPJMt7Rms1fKOIcaqi+Dnw==
X-Google-Smtp-Source: ABdhPJyR90y216Atk3IXAqXj30C5LX+8CkR8WAGUurWczikG0k5KVleq2jDJ0K4Fp+FoJLZAsypiPw==
X-Received: by 2002:a05:6402:5251:: with SMTP id t17mr3415610edd.397.1639758332352;
        Fri, 17 Dec 2021 08:25:32 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id h2sm3738503edl.85.2021.12.17.08.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:25:32 -0800 (PST)
Message-ID: <b3039ba9-934e-0090-f5cd-66d4d11c959a@tessares.net>
Date: Fri, 17 Dec 2021 17:25:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 06/21] mptcp: netlink: store lsk ref in
 mptcp_pm_addr_entry
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-7-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211216222314.1244708-7-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

On 16/12/2021 23:22, Kishen Maloor wrote:
> This change updates struct mptcp_pm_addr_entry to store a
> listening socket (lsk) reference, i.e. a pointer to a reference
> counted structure containing the lsk (struct socket *) instead
> of the lsk itself. Code blocks that directly operated on
> the lsk in struct mptcp_pm_addr_entry have been updated to work
> with the lsk ref instead, utilizing the new helper functions that
> operate on lsk refs.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_netlink.c | 62 ++++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0cb03d78e22b..29f6d01ace2d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -35,7 +35,7 @@ struct mptcp_pm_addr_entry {
>  	struct mptcp_addr_info	addr;
>  	u8			flags;
>  	int			ifindex;
> -	struct socket		*lsk;
> +	struct mptcp_local_lsk  *lsk_ref;

Linked to my previous email: same here, please use tabs like before.

(same in other structure you modified I guess)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
