Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6107E
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 15:58:44 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id fy37so3849991ejc.11
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+jKvTrWPepOhD8CSN/GYyzVRwfmlE/vFiEjoWJWJlw=;
        b=Q36OszNjqN5/8hakYQu4T5kiSnYcstghLS5Y29LZMtawO/KlnqodXIj/hwSquacvFG
         98EEB2LylYtYAhkmAaRIaX9u1XbNmtNwK0/nkhRxwjJReJydW3Daipwf0DEcrIIa9VJV
         N+cJBwn4blZfHVeGHfgJCicAn35hq8GNY3HqfOkzScBpaj2MfOJFaQGbxWNetVVICOKp
         /j1/cjiN5aeLPP7Co0u09oQQlEE8QP+FIQq+IBQX+wU5Viq4owbb/XyMXERhJz0RpSZZ
         Ui0dXseNU8fyqra46judJ2pxgDQWiWhPFHO1r6yN3r4ys4Ht5EfwZHr/gA2QciHnZlN8
         e55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+jKvTrWPepOhD8CSN/GYyzVRwfmlE/vFiEjoWJWJlw=;
        b=0pGBgDYo/gIac3UZWPC+eI1M9KnOUp2TYB+AqZAz1pOqAj6Jx+nRj7iiIlh02PIJn7
         GdnD7avl+ZpYRrAKgV5hchM2+uAFGy00CGLvHdOsfbUfajq2nfDNwaWw8F4rrxN+51dY
         J1N2QtMVX2GFuy/RK/TXrjX/W/j8puEyh/elo+tecsEweNKE6PevN5/Fj/mbdamny6do
         nxX8OYGN+t/TKGz2IaBrlB0sjqfLOWMsr7Tej3/wzKr5+CkwvPz1oreBaPBzQAvlaog+
         sby6iiNATXJvbJNdDCvywkvNGFul0q3XqyZ4YLR+rIl2Ost5JkybVlairxKWejNDDU8s
         NnUw==
X-Gm-Message-State: ANoB5pnYSAx6q/4LIULnGnbN4Ga+8BIZm2g/XmCst+P6au6XR7oxIeEt
	Tsnnfzy4fKkSahMJPmyXl8tmRg==
X-Google-Smtp-Source: AA0mqf4ukKWluTY2M/CGJLDjnHgialc36U+BoVoj6AMUKyw6pjFtTvw7j32SevK3wPNRSwz7rP7oCw==
X-Received: by 2002:a17:907:774e:b0:7ae:39b4:7208 with SMTP id kx14-20020a170907774e00b007ae39b47208mr8488743ejc.766.1669219122491;
        Wed, 23 Nov 2022 07:58:42 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:aeed:e7e9:2ae2:91e2? ([2a02:578:8593:1200:aeed:e7e9:2ae2:91e2])
        by smtp.gmail.com with ESMTPSA id j18-20020a17090623f200b0078b1ff41f05sm7314615ejg.43.2022.11.23.07.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:58:41 -0800 (PST)
Message-ID: <0b86b2b1-1a5c-d500-fd79-c23f2fd4a5ed@tessares.net>
Date: Wed, 23 Nov 2022 16:58:40 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: add statistics for mptcp socket
 in use
Content-Language: en-GB
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
References: <20221122034923.804955-1-imagedong@tencent.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221122034923.804955-1-imagedong@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Menglong,

On 22/11/2022 04:49, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In the 1th patch, we do some code cleanup with replease 'sock->sk'
> with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> use. In the 3th patch, we make mptcp_connect can exit when receive
> 'SIGUSR1' with '-r' flag. And in the 4th patch, we add the testing
> for this commit.
> 
> With the commit e8695e504942("mptcp: don't orphan ssk in mptcp_close()"),
> I belive that the testing of diag.sh can pass now. In fallback and
> simultaneous close case, the msk can't release normal (sometimes?) without
> that commit, and makes the testing fail. Enn...let's just see that the
> CI is saying~

Thank you for this new version!
I was waiting the feedback from the CI to start my review but it looks
like the CI was not able to apply your series [1].

I just applied the series manually, fixed the two conflicts I got and
sent it to our repo[2]. We should get the results later on.

Cheers,
Matt

[1]
https://patchew.org/MPTCP/20221122034923.804955-1-imagedong@tencent.com/logs/git/
[2]
https://github.com/multipath-tcp/mptcp_net-next/tree/patchew/20221122034923.804955-1-imagedong@tencent.com
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
