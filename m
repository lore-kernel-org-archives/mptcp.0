Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B68168
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 16:24:08 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id j21so5431597edt.9
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 08:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=XXEgNOe4gZSWREV+OzXpNPpmJ/NmIApdZTEsOJS8xvM=;
        b=2wPj8gMyg1/vrUyneQ90QtqtEpRbtAWGqa3KDGTAN51eai06Q/nssCHlQPx1NJzOPc
         h04apNIXNGu8ZZLzP2yRoEpdq+jhdfYFPL3Vu8lCllnLtiyIuA6F4AccUs4JxJT9T8nZ
         dAixEH3lDsqUUQw+xY2hCj/D719AjcOXZ4B27sHMf7EJ/yd0vCpOIpUcK9eHPJl9qF5y
         Zqt57s1gGbuWCsppShvvgFkIPiEs+lNwKQ7I+SvM8PYiNhdA0FgBF97o04s8yBFzqq+C
         0ysUcBUOfzmXwQ8LYEY57fmqRIQkthiUYUqaIZa/OZGRNW3aSHsNk0Z62GYjAZ8Detaj
         hLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XXEgNOe4gZSWREV+OzXpNPpmJ/NmIApdZTEsOJS8xvM=;
        b=E4uItVrJenR4Ixrv1CcuzCYZHDjU5/xQIPIJ2pfy2zE7njX6QQXnCnwzvQ5N0oRbpF
         jiKci6GJCjyOfetvo6/u3TN/Byti9kfnraOIyNPxJHuuEgGyT2/od6pGui/4+97Y0bIh
         0LEGn8HrWoZPrpavhIEZ+lUJfIrq1x22nRiLRpL8j1pZYhuHhsIAzrFVwJbqz4YIYOQF
         oC4HxYSRzUNXV7j6WWUlAZ4hGBX4nrQDHPoLGoY1iZHZtISNrkOG2FlZFgLnj8wtTRLa
         AcTdZHVSe/cs32rOREY+NkAmj4VOPJqDk5rkuF2VJuhSTxiA+9BGuzfhuM/n1rmPJedw
         HX5Q==
X-Gm-Message-State: AOAM530ZOako8dYNMgMsQZhc9GkPq4/CH4GLZp8BVvEPsfK5V4cNfl3D
	D5ONaAhBk+b1frQo6mR6Jx0DwCcTvaisxw==
X-Google-Smtp-Source: ABdhPJy9538oIpa+nuVJmaS2Hrx+3NhHKVWfyzt2AHTC08snv4RQc+JkrvF2YE/Vy3YKc7RetgvK7g==
X-Received: by 2002:a17:906:39c8:: with SMTP id i8mr1333086eje.335.1639758246497;
        Fri, 17 Dec 2021 08:24:06 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id j5sm3029122ejo.177.2021.12.17.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 08:24:06 -0800 (PST)
Message-ID: <ef12f796-ffc6-9717-bf28-9047355c5d81@tessares.net>
Date: Fri, 17 Dec 2021 17:24:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 05/21] mptcp: netlink: store per namespace list
 of refcounted listen socks
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-6-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211216222314.1244708-6-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

Thank you for looking at that!

On 16/12/2021 23:22, Kishen Maloor wrote:
> The kernel maintains listening sockets bound to announced addresses
> via the ADD_ADDR option to be able to receive MP_JOIN requests. Path
> managers may choose to advertise the same address over multiple
> MPTCP connections. So this change provides a simple framework to
> manage a list of all distinct listning sockets created in a
> namespace by encapsulating it in a structure that is ref counted
> and can be shared across multiple connections. The sockets (and
> their enclosing structure) are released when there are no more
> references.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_netlink.c | 76 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index fc07ab9a53ba..0cb03d78e22b 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -22,6 +22,14 @@ static struct genl_family mptcp_genl_family;
>  
>  static int pm_nl_pernet_id;
>  
> +struct mptcp_local_lsk {
> +	struct list_head        list;
> +	struct mptcp_addr_info  addr;
> +	struct socket           *lsk;
> +	struct rcu_head         rcu;
> +	refcount_t              refcount;

Small detail before I forget: please use tabs for the alignment.

> +};
> +
>  struct mptcp_pm_addr_entry {
>  	struct list_head	list;
>  	struct mptcp_addr_info	addr;
> @@ -41,7 +49,10 @@ struct mptcp_pm_add_entry {
>  struct pm_nl_pernet {
>  	/* protects pernet updates */
>  	spinlock_t		lock;
> +	/* protects access to pernet lsk list */
> +	spinlock_t              lsk_list_lock;
>  	struct list_head	local_addr_list;
> +	struct list_head        lsk_list;

Same here, similar to what is done around.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
