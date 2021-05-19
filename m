Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591671
	for <mptcp@lists.linux.dev>; Wed, 19 May 2021 16:33:44 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id n2so20867019ejy.7
        for <mptcp@lists.linux.dev>; Wed, 19 May 2021 09:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LMJLUn9Rv9LrsG4vkThUS64Fr6tMsZ4bQvaCdFxZbTg=;
        b=tEnt0Bcu15thCIOpan5PqnhO846IEqR7K/DA3Wbt7D2DeD+Fyz7NzMhJp1EGHTEAWR
         5VdPx2ENrilnYeyOzoS18wwPpq+kPQ1s+lw8Ba2Q+sMkjXTR5qBHJQbdfJSltNy8B1zR
         qUbVYrfkxwmXN7fiskQDN71wE1HEIDAY8IAi17665e8d/0G4BaxJ+tQS+c4E83i2zPDh
         RpgVaC/1P0E4/oEKjARqazweBdhJGO7/BaVpsG+vbUhj4K5Z78yWV1GhcxKd+eg6nkf6
         n5jU40R3WMNYpTElW0lbE5HIwvwLGgzpqVaU3O/r9UERAi/BqTeosUO6WnYnI5x1OMVR
         kiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LMJLUn9Rv9LrsG4vkThUS64Fr6tMsZ4bQvaCdFxZbTg=;
        b=aF1VWRuGLOXCQxuimYbS7Oi0LNtDrE8bbJQn0Rkg9LvDkKgxn8sdthVzMj0SGZgahl
         LYyQ+8UH5BwmEtJ6m5OeXrkNvqSpb1N4grayL3l2w3UahCYxJc41jFKqpc6wk28HQgKs
         GWHXdf0XxfkzZNWWyioTN15T1Z8aIJQv4ADoT/lIlCYsHeopVYOajlKQptpmAiEe4wOG
         TyAhnHO+P7KBK5byTZHKzG5niwqY5L22AqxwmrfJ0/vlTOp1nr5s/N0EFr/n33Tj5p1Q
         Oe2UhGGQYz1TJuKsDPr2Ss9+dTEV7pByN9ScrU7fqIFmB01BypvchmIONylROSFOHUG5
         WAfg==
X-Gm-Message-State: AOAM5328ikWHjpA3yEyf9VciMqBrfK5SunGfl1+36im5DbWo9Lj9NUJj
	qetbW1alhdAnaAltfra5jiXeSgIGYzSCZeeK
X-Google-Smtp-Source: ABdhPJyWHbsknflFRuwrCiQvzMFKorQ8EH/RKn3Lbzgm+3MAu93ocWH1MERWqFVd83W+8oyX3jK5ZA==
X-Received: by 2002:a17:906:ca55:: with SMTP id jx21mr2476ejb.161.1621442022602;
        Wed, 19 May 2021 09:33:42 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:4ebb:3a1d:fec5:80e3])
        by smtp.gmail.com with ESMTPSA id i5sm30890edt.11.2021.05.19.09.33.42
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:33:42 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 20 May 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <681fce4a-3197-dee2-2513-0757ec53daee@tessares.net>
Date: Wed, 19 May 2021 18:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello everybody!

Our public MPTCP upstreaming weekly web conference is scheduled for
tomorrow.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210520

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
