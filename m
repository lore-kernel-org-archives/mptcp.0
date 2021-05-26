Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB02FAD
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:50:36 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id h16so2346343edr.6
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WBKuW/HWdT+W2/GNBaWxzwB2mwcXrK6m8LPzDxXNblg=;
        b=k+7MJUh2QeY+UHHTH5gWm80MpF6COZG1QQPZwVHjVkcGv63FX035/yIUjPq6yRNfQm
         Q70/21Y5F6ieJUeBoUhgYh9QaT44ED4O/Hx9XYnSVrT2UCMiU7JR9n2lG4Q9h/gQoi9B
         pzYy58stApG49fbskNdAsOnkqDkXhhl7Ha43DoN/TMxDsSmvvWb4HzIVosWkS30SQfse
         vQCJoM9I7R9rscYIUxx3+BlVVcKdpWAh4LYuu37oCL6OvJOsWdEC1EVJJ4IjVDaOjZDJ
         YmPjopjKQi12QyAuzOJkVC1mTiOwXlY1xwuMkjscYh6tyKl/s1t6iMNnApdw6z/ikWVg
         P4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WBKuW/HWdT+W2/GNBaWxzwB2mwcXrK6m8LPzDxXNblg=;
        b=KpcOJb9mQxPLm/NaQ+5hK/4jjGNawXTRWU7hENd1cR239iNm4jCMadbs+HaOzx/ZO4
         uSDIyOw/Rc5e+hnVx4MUnjCFIIUGN9wV6ZZlmf8cPY2LfeK311YUppMqCNE0Z7MudqtG
         6SnFTqspI/PnBF7bj56FMywIblkVPYIQ27gtvwJQ5EhjSDGlBaAEwhnZP0awqXIU4HS7
         Vm7p4M733w820OYoAgy8pC4+RftI3PMQ9mfDXZ37G6kkS5P+XOgN05QtFIaTYk/1r9+2
         V3eHymi3rBz8V7h2TTgasG34gdVIWPnNwo+eDY1Rx28vcqJlEhaytFow+U49sso0zn6m
         eOCg==
X-Gm-Message-State: AOAM533O3Qafh42ctgZ1KsxE7O6cgdXKVQwelWMYw0RfpPjbBBVftE/+
	IKlF7r0EAc2RL5BVuB+3oecqBoCe/8reUfDy+w4=
X-Google-Smtp-Source: ABdhPJzIv6gA3KZntmHkNKQu5s2Zc3VJ9Rif6sSGg1EyNhe+1EZRnuVWAR6/tJWfwEuNENc1RAGAVQ==
X-Received: by 2002:aa7:c4c2:: with SMTP id p2mr37363604edr.144.1622047835206;
        Wed, 26 May 2021 09:50:35 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:a52a:a612:5e57:78a])
        by smtp.gmail.com with ESMTPSA id h7sm2213449ejp.24.2021.05.26.09.50.34
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 09:50:34 -0700 (PDT)
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 27 May 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
Message-ID: <7c6e5e10-7f3a-d6ab-48fb-5e203cf4110f@tessares.net>
Date: Wed, 26 May 2021 18:50:34 +0200
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
https://annuel2.framapad.org/p/mptcp_upstreaming_20210527

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
