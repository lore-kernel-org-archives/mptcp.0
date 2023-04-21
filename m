Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2B3C05
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 14:16:01 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50506111a6eso3019543a12.1
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682086560; x=1684678560;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aNqILpCLpcux6+rvrEZsW56izM6hX6ggR5L9DwFlHg=;
        b=fHlbtH3b0Fu7OUHnzoqxahMRvjjYlJg+HY3IC87fkDcX9NAcBOygrSo0x1EfddUOPD
         3zD7lMG7v8MSdVieELtnGOJ3Nh6JBafIw+yEW+cnopaivo0MRR7D2wm6Ny+MMmfV8831
         2S6IXBOgUTh744qMVC56mtge9uUAwA0Tt+uleTf8sxcHihXrF+2P7TmA1OQvR1oQ7x2t
         SjeJF+J7FDtaEBAgHjOjh41j3QXkaGj/Bv8aALXrVs4RtvJsmqumC2iktOS1z+fF0Cn0
         WMSpBy2UBpMWqGXTO5syViO/qTYLbuvYLtmNdYEYxZ/N3x+phiMotI/PqYnQllesAUL+
         jCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086560; x=1684678560;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aNqILpCLpcux6+rvrEZsW56izM6hX6ggR5L9DwFlHg=;
        b=Mas4B0V+chYFt3NGkZj4ylo0HLt9dGit6Imz7YvHDzrtQfGRgC0MNyhwc04Bu30BTc
         8Rtn1f5Wpp+CvkH0Qikf0WzE5SDF3V1GigRIrPzRBPfNWJPX/s0TIEpmzsVudXy5RLvv
         Ia7O3cQBwdLp4ulwmgGYxa0Xob4B5aaCLDHl25+SkRYALzaLtmi2Z8jLkRPJryAX+5nI
         7KzwKiLs615jpQ1Z8I8uv5IaiJ4Ux8CiHPJm/Q2ZPLBSaANNdpb2rnIipPPPBY+0jrQy
         YAJqmEUHbNJ0ynvqhRRitOL4BTuptPATpjsD1eg1Rrihjcjc4H7BydLOvfwbjwqESSyv
         nDuQ==
X-Gm-Message-State: AAQBX9eyoXRI0gkRnNJsfclUUaXL7XXqFcW+D0TuTnm1uTbQm6uF31Ku
	DnW3dTs6rhMhdGUKWBOKOHB0J3wEBmWsnEflLdmeAA==
X-Google-Smtp-Source: AKy350YaJCHp1XzHEDEoVf82I7mVC4s4+/g8XNW+SGhd3G4d00f6kuDIDKekfI58btm+EUPrTXSxmg==
X-Received: by 2002:a17:906:b197:b0:94c:b183:bb6f with SMTP id w23-20020a170906b19700b0094cb183bb6fmr2376660ejy.18.1682086560134;
        Fri, 21 Apr 2023 07:16:00 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id gz6-20020a170906f2c600b0094ee2b8ab77sm2105907ejb.73.2023.04.21.07.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:15:59 -0700 (PDT)
Message-ID: <7f6d74b1-86dc-2c0f-ea5a-8a1907b787cb@tessares.net>
Date: Fri, 21 Apr 2023 16:15:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v8 2/5] selftests: mptcp: update userspace pm
 addr tests
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681960259.git.geliang.tang@suse.com>
 <6c50f4b82533d9499318cad9d8c846823d7e280e.1681960259.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6c50f4b82533d9499318cad9d8c846823d7e280e.1681960259.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2023 05:11, Geliang Tang wrote:
> Update userspace pm addr selftests, by sending a remove_subflows
> command together after the remove_addrs command.

To help with the management of this patch, either add:

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")

and explain in the commit message that this is linked to the parent commit.

Or squash this in the previous patch.

I think it will be clearer and easier when managing stable versions if
you squash this patch (2/5) with the parent commit (1/5).


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 26310c17b4c6..9a9b6e9b28ab 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -850,6 +850,14 @@ do_transfer()
>  				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
>  				sleep 1
>  				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id

Please see my comment from v7, patch 7/7: should we not do the remove
address after having deleted the subflow? See:

> (...) on slow environments, could we not have a situation where the
> REMOVE_ADDR signal is sent to the other peer, it directly reacts by
> removing the subflow and at the end, this "dsf" command is not doing
> anything, causing the test to fail because it expects the listener side
> to delete the address.
> 
> Should you not first delete the subflow, then send the remove addr? (or
> skip the deletion of the subflow command and expect the client to remove
> the subflow?)

So just moving the "pm_nl_ctl rem" command after "pm_nl_ctl dsf", no?

> +				sp=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				da=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> +				dp=$(grep "type:10" "$evts_ns1" |
> +				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" lport $sp \
> +									rip $da rport $dp token $tk

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
