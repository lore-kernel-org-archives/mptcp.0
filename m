Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197B2F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 15:13:57 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id q7so10070648wrc.13
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=D2cIDqAPBf4YcffLCyyak5hbGW8HPaooH2/Ex9YJ+Us=;
        b=xoqYqikSR5fS5PxBD+ttHOh3kSlNKFgkcEBj0WuZxvT6MV+Gwq/0mTpdJ7pJScbQnC
         IvQGcrH3Z8hOKpaJkYt+ljn5YSn4x0kmf+zTq5eiplQEWdkf8whny7mtxYPPJqk81kje
         N6CB41+SJngKj/F6v5zVjT/jXeef5uJWDrD8kXHKHiZUY22pqDOF/HabTZsn9GZ7H6mS
         x7KD7QUqOXzFIqI0lnoY2O+g2C9Z+SBmpju8ry+mYZLtyqV1F7/akekDLmqS3RhnsQfJ
         CcxvYM4qywmC/2f2cJObmTTpxyE7RUEV/ExNHkUVABmAOwa0dbfgIEvLNRtOWyob2r32
         pRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D2cIDqAPBf4YcffLCyyak5hbGW8HPaooH2/Ex9YJ+Us=;
        b=Igi0zlgw0zzq1PcTXp97hjxbl8morVqxX9YW9Ni4m9mMlnTRNMw+eKs1gvZrF/MhK4
         PvZ3EDDG4DIKxMBWbstX/k14hfjJnQhjvalG1KzagqZSfGnhF2LrC6WrbFSnUM3e578w
         +X3uvIFU/vsok5LnAuP9dwaLaT0ybyLSAX3RMBYHDlMA2/ze04OKA1Wn6BNsVfgGE3nr
         9q/yS0DEDr8ebVQCPmEttlJDL+LZ3vugYLtCJn21GewQEQI7NHMupu4lDDN9d7/HyJmT
         NzyjJNezpt0fA9kp1Zw0HIGWchBPlCpkJ8LhIQoprDyJAeCg5McGd3Um0t+OCTMvvAkP
         0NEg==
X-Gm-Message-State: AOAM533FVtUPDzpLDTnU+cMRm8CppnW2pLS5KMp0FXrtUKsMG4fCW/hl
	pgW+CWAVDeNCryy5LcDXC8G6pHOFkh2lB3DW
X-Google-Smtp-Source: ABdhPJzyRKQC0rvV4htkQ41haDcpzA2lD3D+FP6SF74sTsX1Tr9bcwrjRl4TaLga5x6sbJSjKgOQmg==
X-Received: by 2002:a05:6000:16c2:: with SMTP id h2mr6780625wrf.614.1644506035281;
        Thu, 10 Feb 2022 07:13:55 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id ay38sm2329696wmb.3.2022.02.10.07.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:13:54 -0800 (PST)
Message-ID: <344dfb9e-5b9a-b804-fea1-46ca523ca68a@tessares.net>
Date: Thu, 10 Feb 2022 16:13:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-net] selftests: mptcp: be more conservative with
 cookie MPJ limits
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <d3aaf62f955697daa23859487bfaa5f1a777b29d.1644426852.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d3aaf62f955697daa23859487bfaa5f1a777b29d.1644426852.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 09/02/2022 18:15, Paolo Abeni wrote:
> Since commit 2843ff6f36db ("mptcp: remote addresses fullmesh"), an
> MPTCP client can attempt creating multiple MPJ subflow simultaneusly.
> 
> In such scenario the server, when syncookies are enabled, could end-up
> accepting incoming MPJ syn even above the configured subflow limit, as
> the such limit can be enforced in a reliable way only after the subflow
> creation. In case of syncookie, only after the 3rd ack reception.
> 
> As a consequence the related self-tests case sporadically fails, as it
> verify that the server always accept the expected number of MPJ syn.
> 
> Address the issues relaxing the MPJ syn number constrain. Note that the
> check on the accepted number of MPJ 3rd ack still remains intact.

Now in our tree (fix for -net) with Mat's RvB tag, without a typo
detected by codespell and replaced

  [ ... -a ... ]

by

  [ ... ] && [ ... ]

(linked to my series refactoring mptcp_join.sh)

- 7c2d506acce5: selftests: mptcp: be more conservative with cookie MPJ
limits
- Results: af8e6fcc9de1..388ba6d7cd29

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220210T151226
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
