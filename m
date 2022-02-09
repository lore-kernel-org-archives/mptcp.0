Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547132F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 12:52:52 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id s21so6909254ejx.12
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=gCpwBq9LhPyi/p7oS2BG5dIw4esDw8YwpJWZZ2xS3+I=;
        b=Lj+v/q/g45oEXK4gv/rtbMIhdAKYZnssW9n9Uqk0XDpXxvpI84WyiFvJKVs4ZjXVEv
         Xytafd6ZkJm/1eRx/kFCmaKXQEPmVeFqEsPneV05GVovAXg/ia1mxWCnBJyrDjAj2C5f
         rgsmwl887+Kx9MTgVW/oo/ZDiFtTyxSR6hcIiiJ9qwk5DNzcGMg71tmpiAMp6Bj9CqTi
         V3B62ZfM02iSLN9ZVinnZNBKbnFPQl/YCWMsO4Y/TM3tuu8wnxe8cjh2PpX0SHJ3d5Ib
         dfUWfWS7U6fpqEFp5U/kbORYFrPgcbuiJVQDiBLfUBg+QHsbUW1oLgVoFcKx+Fn1eDXx
         /d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gCpwBq9LhPyi/p7oS2BG5dIw4esDw8YwpJWZZ2xS3+I=;
        b=CCZzLtPfw8u/45Qpa/tKd8VpjHmNSWUmPHWv25GUBUaHApzSKWvf3KTK539tX39jKT
         7SfZ081+/qFSr/eGohogUtUimbzgueHJ4myvuPiPNiuq8i9lZFX7xfz0kgN9vFN/0++k
         H/T9jL3HjFF0NyHOML2h66G2bsw5L8xTN5AYlzR9jufaYhegDyYUWpu6iGsIobaZX3iu
         x0SbP8OUvRoN4mOB1c06i3XMi60mAM2ugRmhOgle21B08rdnfdYpJr2DYpBSaq3y64wx
         0zNvHlFZF4TK11cozSO+PItxcgJdem8FsjafCWfieOCdoTQlD2PmozfWa15VRQvbICXN
         8xLg==
X-Gm-Message-State: AOAM531he60BfQvYD0DPPTmGV1miKwnbxw9r0IsEv+l/cKsmZcoNOzVN
	9Cqh4BZjOJg1X6RkQGZVJ1krzTykjxe+xg==
X-Google-Smtp-Source: ABdhPJx3q8f83ynsYBiyjO0sWLE5W/bgR6IddBKc2GrhG3KhLX+0hkKON0A5n8RL9mUEQGj8cBnTfQ==
X-Received: by 2002:a17:906:6a0f:: with SMTP id qw15mr1851378ejc.66.1644411170534;
        Wed, 09 Feb 2022 04:52:50 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:42a6:e0be:778a:86e8? ([2a02:578:8593:1200:42a6:e0be:778a:86e8])
        by smtp.gmail.com with ESMTPSA id l16sm2351659ejz.103.2022.02.09.04.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:52:50 -0800 (PST)
Message-ID: <d7c7ef92-52b0-d2ef-5662-e9ac1ddfa68a@tessares.net>
Date: Wed, 9 Feb 2022 13:52:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net v3 3/4] mptcp: add mibs counter for ignored
 incoming options
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1644399915.git.pabeni@redhat.com>
 <3ecca50d02f7d75f9f4dc166f80ebddb3d91bdfa.1644399915.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3ecca50d02f7d75f9f4dc166f80ebddb3d91bdfa.1644399915.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/02/2022 10:47, Paolo Abeni wrote:
> The MPTCP in kernel path manager has some constraints on incoming
> addresses annunces processing, so that in edge scenarios it can
> end-up dropping (ignoring) some of such announces.
> 
> The above is not very limiting in practice since such scenarios are
> very uncommon and MPTCP will recover due to ADD_ADDR retransmissions.
> 
> This patch adds a few MIBs counter to account for such drop events
> to allow easier introspection of the critical scenarios.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/mib.c | 2 ++
>  net/mptcp/mib.h | 2 ++
>  net/mptcp/pm.c  | 8 ++++++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index c12251cb0d44..d544b5304596 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -36,12 +36,14 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
>  	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
>  	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
> +	SNMP_MIB_ITEM("AddAddrDropped", MPTCP_MIB_ADDADDRDROP),

Do you mind if I rename "AddAddrDropped" to "AddAddrDrop", similar to
the enum name and the title for the RmAddr?

>  	SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
>  	SNMP_MIB_ITEM("MPJoinPortSynAckRx", MPTCP_MIB_JOINPORTSYNACKRX),
>  	SNMP_MIB_ITEM("MPJoinPortAckRx", MPTCP_MIB_JOINPORTACKRX),
>  	SNMP_MIB_ITEM("MismatchPortSynRx", MPTCP_MIB_MISMATCHPORTSYNRX),
>  	SNMP_MIB_ITEM("MismatchPortAckRx", MPTCP_MIB_MISMATCHPORTACKRX),
>  	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
> +	SNMP_MIB_ITEM("RmAddrDrop", MPTCP_MIB_RMADDRDROP),

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
