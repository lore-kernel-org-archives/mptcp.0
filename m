Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655872
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 15:53:04 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id ga14so9071132ejc.6
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=L0bq/fpUBWCsWnFNyiL7gcBqA4Cz4wQc2GwOscTJZKY=;
        b=mY687GCcijRTvDjh850eItPk8q3rlpAkq5OdeVFcCMvav/sGbYwlSs4Ubit1q/dbVE
         8cqp0VMbaJfKkOYTouZVppl3o25RZLUnDXg+l4XwSGbBvB02O/d//7S7Yx0uMXexWHe/
         YMO8GfrvIFr4cko8/gdkFLxeIYaevz9xof3ajZEDaII+XudAGTmLqJOsJehCBAHvrZyf
         y60OE9rbKVKnaEsOIexv+GQqhtm6KByB+kuxTybPn9qae5muMtR8qZvwxeshKMoXXvZr
         z3OTKfmEqvofOvmtwJNl/wDBCn5XEC8qSSZ1vpdNpJCejikvM5cKwBJavKC3BUGrZdvZ
         efnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=L0bq/fpUBWCsWnFNyiL7gcBqA4Cz4wQc2GwOscTJZKY=;
        b=PIAxgbZXgqbFE/+iCqXU+RxYYTFGEnmG2vOVw3JJWfccoiGiW/E9Ory9/R8Aurk2vw
         PJWpOiLqGxXOOTtqx74eFYCefhYIr22R+bjOKOyz+0vh/dy6YlNrk93w1tG+m6tv7oxd
         jTDbF+X+5sVcUqJ1oOnlisr8Dlg19WyJL17QcS/396FWrPr2uqB5z6LgH/ztF09UK03J
         OpC2trpf74WQ945miRvsYkH1j5xW6O0m0OAQTYo0F+vCqftYrFsv4YEuYUJ7mP49A0mV
         EyBd7M7Rw9LndK8/retEFGFjH3jg9VQOhkbP8V5gbjK+a6EQKZaYyHqz1wnqic5vj8Qp
         4q1g==
X-Gm-Message-State: AOAM532zbC6XfbGbT181WaW8jcLvmLcO/h2HIJm4ev2Cn0a5sjsXeT+P
	L7N3SgZLdiGazSiQLLyF9DxzhANesA8JzkEbUcA=
X-Google-Smtp-Source: ABdhPJw3QjQC6Gcl+h/X2xHJnBxwElG24x8D/NInOb4BnJKlOQhzNqBPoJUYh6ccRv7bgasODXCnXw==
X-Received: by 2002:a17:906:f84a:: with SMTP id ks10mr499304ejb.537.1626969182937;
        Thu, 22 Jul 2021 08:53:02 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:a2dc:f69d:fe16:9f4e])
        by smtp.gmail.com with ESMTPSA id hd30sm9582015ejc.29.2021.07.22.08.53.02
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 08:53:02 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [Weekly meetings] MoM - 22nd of July 2021
Message-ID: <02aa6398-5b84-0f57-980d-9aa934a15035@tessares.net>
Date: Thu, 22 Jul 2021 17:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hello everyone,

Today, we just had our 158th meeting with Ossama (Intel), Geliang
(Xiaomi) and myself (Tessares).


We decided to make it very short: a few people were not able to join and
there was a blackout in my village at the time of the meeting making me
hard to follow the discussion with my phone and an apparently overloaded
cellular connection.



About the pending patches:

- MP_FAIL support:
    - Mat reviewed it, changes have been requested
    - Geliang is working on a v5

- fullmesh path manager support:
    - Paolo and Matt reviewed it
    - Geliang will work on v3



On the CI side:

    - a couple of compilation errors introduced on net-next spot by the
CI this week
    - external patches have been applied in our tree (already in net-next).



Next meeting:
    - On Thursday, the 29th of July.
    - Usual UTC time: 15:00 UTC (8am PDT, 5pm CEST, 11pm CST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20210729



Feel free to comment on these points and propose new ones for the next
meeting!

Talk to you on Thursday,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
