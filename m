Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB52C96
	for <mptcp@lists.linux.dev>; Mon,  8 Nov 2021 16:56:31 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id o8so65102277edc.3
        for <mptcp@lists.linux.dev>; Mon, 08 Nov 2021 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=J2nSA1v7Vn9omxro9lpa4tnAZ5pStmHBKpEerFcJl7c=;
        b=fiUTPh8NGUIdUEAy9veX+ZrBRb3IK8SsJD3RUnHmAIvxZBKSMvfMfvuHRfPcCrIzNf
         vIG6DnR/NqoQDolOgG1uOEdxkeHSeVCMXQS/uyXumxN9lu4/OcANrrmCxlrLG2YJC3cD
         0zGKs0UZ+9xNLV2vdHz73nQKfjfdBHg00Jn/WU/ED+iBvNQ646y6gNAG4sAftUbdVIAT
         +SDtyD//Kd0jwh1H3VDvS8PyKKb42DQQP5BV/KybOAI+hDsSG1bTRg3ZM1SJsxZtmebC
         9Zy4smlBx7mo4hk7A5CNED2eN0/gKj1hMPo9k8X1J83vd/W5lxd/Pm4Wkn9tYR8xja27
         /pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=J2nSA1v7Vn9omxro9lpa4tnAZ5pStmHBKpEerFcJl7c=;
        b=Ch2ZeHpxhFZhgVOH3wmuh3IMDpb9uP68StuTowvEZSZmBrNb/OwXQSV7wfsA1hHvh2
         rsJbMHghw3G/FWpwoC/F/xQ+/kUdBf2f+Ihl/Tmq4kfDT6ZNCys7V3qHsvJcxQ7POyJh
         Khkckh3ok04rymvK9Tp7T9a8BYpkeqPLN/5quzOCRcKEFZyPTzXq09xGP6IdO83SZ0nz
         wu0GaFeCgyfbCqTUBoyA0f0ZbS/Wgo8ozxGmo6g6qm/s3Sk3jCwE9HfVSuRSuyigocNr
         liFh9DHbO+mXPe9BBsjQ+fdvVjSGmAbpCynAMqV9gwWcI23WKhOuNuJYcPE8aCTxHU30
         lXww==
X-Gm-Message-State: AOAM532r1WOEk0dqm0T7EM85mr7Hffq+rWj7L2TD8dzhiRvUUx0sW35V
	PCxQQ2QgCalGs7PQZWOqp/7OD9Eed8bLUEma
X-Google-Smtp-Source: ABdhPJxQyMYlYMq6cwYl5u+x7Dwt5ts6TUjl0Q7lC1gIBdOghxNHCP4PZekEm5v9MoSmEV4LzYqUlw==
X-Received: by 2002:aa7:c5ca:: with SMTP id h10mr730658eds.194.1636390589540;
        Mon, 08 Nov 2021 08:56:29 -0800 (PST)
Received: from [10.120.18.54] ([84.17.46.18])
        by smtp.gmail.com with ESMTPSA id sb8sm6863653ejc.51.2021.11.08.08.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 08:56:29 -0800 (PST)
Message-ID: <340eb5be-4fa9-5cd3-1224-3e37e4d538ae@tessares.net>
Date: Mon, 8 Nov 2021 17:56:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH 1/3] mptcp: never allow the PM to close a listener
 subflow
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1636107361.git.pabeni@redhat.com>
 <f9e8db7159b3e0db8dc5b642abdfa9019ada435b.1636107361.git.pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f9e8db7159b3e0db8dc5b642abdfa9019ada435b.1636107361.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 05/11/2021 11:49, Paolo Abeni wrote:
> Currently, when deleting an endpoint the netlink PM treverses
> all the local MPTCP sockets, regardless of their status.
> 
> If an MPTCP listener socket is bound to the IP matching the
> delete endpoint, the listener TCP socket will be closed.
> That is unexpected, the PM should only affect data subflows.
> 
> Fix the issue explicitly skipping MPTCP socket in TCP_LISTEN
> status.

Good catch!

Should we add a "Fixes" tag and have this backported in stable versions?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
