Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC842569
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 16:59:14 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id bg10so34879749ejb.4
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 08:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=rwSyi+PK7aQ5xa5fQTG5XaqHavQAXdZqupvr0USgQ/M=;
        b=X9fsG6XGdypoVuxK/R9oJpdrE3fA3P1c3d253+Qz3EcwpoeqoPXAlTujDCOSsnguxK
         Cm3EtsyzkII5sw9sr303arrlW/qM4/Cgx+rVLbxVxabynsh4ieq0p8me51yY0uz7PO57
         3bHhWsYWYGHWibarNnjUyltgb1uNx5KvXUZXPEMsFajapVWH9+sTtgbvqIb/ITXL/jOs
         sjTMvZh6BIXYyczNWopSj57T1PPR+o3aUvNnbnWlx8z/74DZXFyUOaeAe6TQqUrihh2V
         9D11h7eH/g7+n4G8NVTwjBYzxi/4mRtfP1YqVx2ViLeD86GGiUY2IJTYiRgyONGiIvFH
         suWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rwSyi+PK7aQ5xa5fQTG5XaqHavQAXdZqupvr0USgQ/M=;
        b=r+KCS6TmFECdvI5ZSiPUxl76zBU1qP8SyF0r1cfwS3+RHtnQc0AbYG3rdpK4S0NbU3
         LyM95xQlbek4UyZXVtO/TXDJCfW1pdmf+ELU//2F9IR+GviLqaoijjCGMqASqwTBeSz9
         jobGgaVUZrUeFF3Im05TDA3gvVKtV+tuicqYDP5g/VWKfrSrhppN5BpTdbMWbnWTdY5q
         FNF+r56C/Txwg7ztb4J1k0H+f6lI2DuAPFLSEXxGCKplhZ05BsgZMLksLTcYnTsGWIR7
         oAs0amDNtfeG0veFpm3WjL8/HxhSJtnrzbVDWiHMqGUAPxWJBStg/sABEQISdGNJ7cX5
         97+Q==
X-Gm-Message-State: AOAM532yqcd4tzg7HJC7SE9lQ580aQYjC7NcwMDkSl0+j4XleuhOKDDy
	jg+TDUwAGli8iikOstPygbZWcw==
X-Google-Smtp-Source: ABdhPJzT40K0JWbrN1fxqWgMUTy4AYaIHJzO2M01DdHJhR9LL/Kolz3WCyY2ZIRno92EbiqNDx8HYA==
X-Received: by 2002:a17:906:2a85:b0:6ce:36bd:bcd9 with SMTP id l5-20020a1709062a8500b006ce36bdbcd9mr16286487eje.318.1645462752873;
        Mon, 21 Feb 2022 08:59:12 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gs35sm5285859ejc.208.2022.02.21.08.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:59:12 -0800 (PST)
Message-ID: <eb708225-721a-7e7b-8503-fdd449833a16@tessares.net>
Date: Mon, 21 Feb 2022 17:59:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: more careful RM_ADDR
 generation"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <a38625a058afb93ca629e300124cfc07a0bc43fa.1645462092.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a38625a058afb93ca629e300124cfc07a0bc43fa.1645462092.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/02/2022 17:54, Paolo Abeni wrote:
> When the self-tests flushed the subflows on both sides of
> the MPTCP connections, the number of subflows actually deleted
> on each side is unreliable.
> 
> The test code always flushes  first the client side, but the
> actual delete operations is performed asynchronously, and one
> on more subflows could be processed after that the other end
> already deleted it.
> 
> The grand total of the deleted subflows is expected to be
> in the [nr_subflows: 2* nr_subflows] range.
> 
> Address the issue checking the total number of deleted subflows
> in the simult flush cases and enforcing the above constraint

Thank you for the patch!

It seems fixing the issue 262 on my side: the modified tests have been
running for a couple of hours without issues!

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
