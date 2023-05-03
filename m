Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F69A52
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 17:34:15 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f315712406so34707605e9.0
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683135254; x=1685727254;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OR4f7XVypySG6B6MxfBUXpYZ3kKezOLe9hjZe3UwXfQ=;
        b=V590Tmg1fwjj0JDw2cAZ9bzG2wxJB01/6Wb3eJVWvUH8jr2RJtu9iCCnWNdOyrs/Kc
         n60DCMkPKYgEpC9Lh+PiUCIHbkDrAPbTTnAwMRWLTdH4mBd4/UzQUP6oIi4hEFT1wCuR
         1F0h3n/AMIsEA3eYFBdb4IuPDszojtMZqy9iLYTx0Gx4kS2Y0G2ksiY9hW9vp9enkE9t
         ZILJglCrq/UhZsedam+7QayUmakjBhCX2eV0P2PfL/UmfiwFphXINvb1glvnoW0jyrTl
         BuK9gO1FtQUWr673vXdLoAWU0JZT/2XrvZPPg4qMUiZfV5Ct5IdRoqk46c0n1IwDvSpb
         IPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135254; x=1685727254;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OR4f7XVypySG6B6MxfBUXpYZ3kKezOLe9hjZe3UwXfQ=;
        b=BD7E6wKxqyd7p8qtDy/WmZsYPrEQ31efpGiEiFqD5S5mwYJoG2OP/7DGP65MvR2R/v
         or5MA+9DvhYnPmN6ZVW7YzIzID2+FoGosmVF2cgIQVwHwo1v8fEztH+m1PY5bcqWdAbB
         EY/UvltMBbSi+huFra6MgqUf8RwIS1XUrFEhNSB71HYraGon3Uho+5gVyCjvDs6Sw+jz
         7b23oEgums0MptqokUOmfKP2UTiit5fetXWGAuSE31rxExpFS3mqL2/6qX7OLE61hHz3
         N2Nhva1gcPMsC4EE4XLgu8U+gHdNrV74JdBkDKoSyjLnzlFlk16kCfmzkdo/RJPMui9v
         RGlw==
X-Gm-Message-State: AC+VfDwKRqR7kfPTUdQ9RFfhEtqjs3r+WBi6Syyha6vJRzKK/60Vz81X
	2crL2nfz3fkMDfDjCON8yIoPCuB1zODQCMyNkts=
X-Google-Smtp-Source: ACHHUZ5VVjSu54qP5kZYEPn+xRu5lQ5RRDhdKQ7WZBmmHgHkaXUqmcayKIP1YfpCb8D2TMbP/drVSg==
X-Received: by 2002:adf:f950:0:b0:2f1:b74:5d8a with SMTP id q16-20020adff950000000b002f10b745d8amr606116wrr.5.1683135254089;
        Wed, 03 May 2023 10:34:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b003f07ef4e3e0sm20592wms.0.2023.05.03.10.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 10:34:13 -0700 (PDT)
Message-ID: <225f63a9-bf6f-7980-a34b-84656b706e9b@tessares.net>
Date: Wed, 3 May 2023 19:34:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v10 6/6] selftests: mptcp: update userspace pm
 subflow tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682499136.git.geliang.tang@suse.com>
 <6d3687d33b1a7f6b40e75047ab09a625ff79d923.1682499136.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6d3687d33b1a7f6b40e75047ab09a625ff79d923.1682499136.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/04/2023 10:56, Geliang Tang wrote:
> To align with what is done by the in-kernel PM, update userspace pm
> subflow selftests, by sending the a remove_addrs command together
> before the remove_subflows command. This will get a RM_ADDR in
> chk_rm_nr().
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 67d5d724266a..19fbe1c34a0c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -923,6 +923,7 @@ do_transfer()
>  				sleep 1
>  				sp=$(grep "type:10" "$evts_ns2" |
>  				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id

Same questions as on patch 2/6: why did you have to move this command
before the destruction of the subflow (just below)? Is it OK even if the
destroy instruction fails?

>  				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
>  									rip $da rport $dp token $tk
>  			fi

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
