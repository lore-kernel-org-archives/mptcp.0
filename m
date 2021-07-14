Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2517570
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:15:09 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id t2so1973969edd.13
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDx+dgysG9dwtO6+gKA0ZDstwnshPAnb4riFEjzt0E0=;
        b=aO6zEum7p6GHoFw38ZzD9T9EcqYdGMvUd6soPnM2Z0uO2Gj53nMaB3JhMT0uXrCMSH
         k0HMOk76WwdJnaW32cY7RkVFGlepvmjFw+FH+fkZZhA2Tsx0jdDSy2p8vOfof8RJ9oBl
         QHaxku0xRtOTG7iPkDxx5k0uTeuF+giETdT5mCAWC2TkTHqnZFDPGdKCGY+Pu0J+uzW8
         wUMlRzpGstLsZS++aK7cP4yuZ8CFGG2HSWg/7Eb2fDDadQLHMmXbTRiXwbmJeaaT61Et
         8V+EsJ+u6UxdnLg/X8IuXjPwMPbzrgsZTWnM/1wTmRxQFDIGBnb89c6+VdXyVsW8joDX
         frRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDx+dgysG9dwtO6+gKA0ZDstwnshPAnb4riFEjzt0E0=;
        b=rUaQPi4ymDVNalIg2ZtRqVBwq8dxvz6Mr1GdI7mWfnac+pgeoyHTv4daduu0ttsfIR
         +ktq54gOnyLKZYx41nIxYteJQSdkFqGQWZIspN3JPMJYJNZbLb5ssXJ0N4eHW/iC1bJz
         e7K6Vcy9fAKKBYERXkn1FHfjVVi/NmxyAWJxqA/LYQAqo9WYkLAzhm3jj0+TgIoAA2Og
         hP9N3uKWMbXM2m9hcq7e5QGXZnH97an2/6qVM6136gLfXtn0J/AuILzDyKv1jARyThTq
         xtjFdBsOo3VWa1pbuFdsCFRozobbELJEv1uqX0oy/FVqIQQuHjpzWVO3j+n1oICWEMMI
         ueGg==
X-Gm-Message-State: AOAM533qf2FTmfYwTu3giGBGhDlpJIiUVlRRU74/N1nRGVv7CcX/BWq6
	k3pvjzoAeL8MDiwPC6DXBYfbOw==
X-Google-Smtp-Source: ABdhPJz8+wtys65G7bPp9GXVekEU1TypX/JlXCGJrg37MT+yytRHoJ7i5twwPkCbTPgxsI/oL92+rA==
X-Received: by 2002:a05:6402:26ca:: with SMTP id x10mr12561401edd.319.1626257708228;
        Wed, 14 Jul 2021 03:15:08 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:19ab:ba02:6bfa:8cec])
        by smtp.gmail.com with ESMTPSA id ck17sm599205ejb.54.2021.07.14.03.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 03:15:07 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next 5/8] mptcp: faster active backup recovery
To: Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: lkp@intel.com, kbuild-all@lists.01.org
References: <202107141117.6wB0621n-lkp@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <4daa4dc7-c30f-8125-9fdb-7e7376f05029@tessares.net>
Date: Wed, 14 Jul 2021 12:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <202107141117.6wB0621n-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Dan,

On 14/07/2021 10:36, Dan Carpenter wrote:
> Hi Paolo,
> 
> url:    https://github.com/0day-ci/linux/commits/Paolo-Abeni/mptcp-refactor-active-backup/20210714-051541
> base:   https://github.com/multipath-tcp/mptcp_net-next.git export
> config: x86_64-randconfig-m001-20210713 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> net/mptcp/pm_netlink.c:931 mptcp_pm_nl_subflow_chk_stale() error: uninitialized symbol 'push'.


Thank you for your email!



It looks like Intel's kernel test robot spot the same issue a few hours
ago [1] (that's good, it was very quick!).

Paolo already sent a fix [2].


[1] https://lore.kernel.org/mptcp/202107140830.4kwYyqkO-lkp@intel.com/
[2]
https://lore.kernel.org/mptcp/1d91265cca09bb69516907f44b5e4b72c4efabe1.1626252886.git.pabeni@redhat.com/T/#u


Cheers,

Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
