Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580A70
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 18:52:28 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id a25so4162853edr.12
        for <mptcp@lists.linux.dev>; Wed, 12 May 2021 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=krv8fqA093E65VgyUEx6y0DcDWNpj9FQ5GflmZvtydQ=;
        b=X8FeudaKRX+ZnUhj/KHBy5eCspoOxBSiHF5gGss5VJu8q3/J+IRNOOVCokhACYOjVZ
         zJ+WjpwB0uitc6oFnkc3I4H7xzhLmTX7a9d0xHjKhCT+bLI8dLLTCALhpRbmefbRYbzn
         vMdVgfKNL4wL8Znq5FyReEMO1OtLjN8aEJCBC3fRFv8pvaCF3YlUQdpUn0M/a+EDnXlk
         8SzixG+q4BegLxmrqyR+2XfU4O6n79pZUN26tfeao7wjLE0WPECpDsDLQ7gaHcUc/n+a
         JNgfpyq/UPYLPPVm7r778za3q5cUNNNvMuutK9fSBio8yOJgb0oxxbjhfaMatbPWW8vB
         /jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=krv8fqA093E65VgyUEx6y0DcDWNpj9FQ5GflmZvtydQ=;
        b=gxOGODWG39wZ+cTNG5KnOnf3PgDHvqjUIAx7xRqZpfxbYZiu+K0/AZ8MyyvXP+l4/q
         Qv3c4RozEzur9eE9Hrm+bhppNwZnsrA9x3mn2rSEoC3xpKthwdfqOEh9t21hf4NloYWr
         fq2zgs6pUnHBPOK04tJDEZBLvvciiQJJg4DX/vPO008B/t2zFHNrIJsDD04cbEjMncuH
         zAO0u7SQpuXRo0vIW+fkHb9Sm/EdB5rOJoL82Cl51Fhe9t/xeqXfnx5FqdSg/YrVx43I
         GPXBXlwBTh4L3+iZH13w5LOa1WHNB1CgU+u/1nZwILuS4zS0DgBuGruzzfiQGXmWi2EZ
         38vA==
X-Gm-Message-State: AOAM532o8eqz228Fu5ORwv+TZrM++uFzwj/1fA6XMGHrGXJGHtJ8RiRb
	4+nTKFWD8/X7cj/2SPiq7YPEcyFbxZoh5uo8
X-Google-Smtp-Source: ABdhPJxGCiK9V4II8rZu2tN2ga3+HCBlLd+G/cQ/eQFUpCV1KoK9Eohttjo33p3HRUHcU7ZxwsQS6Q==
X-Received: by 2002:a05:6402:144d:: with SMTP id d13mr45205269edx.101.1620845546794;
        Wed, 12 May 2021 11:52:26 -0700 (PDT)
Received: from [127.0.0.1] ([213.211.139.128])
        by smtp.gmail.com with ESMTPSA id zo6sm346891ejb.77.2021.05.12.11.52.26
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 11:52:26 -0700 (PDT)
Date: Wed, 12 May 2021 18:52:26 +0000 (UTC)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <b3ab186a-6941-4ea7-956f-1b8483af23ba@tessares.net>
Subject: Weekly meeting - 13 May 2021 15:00 UTC (8am PDT, 5pm CEST, 11pm
 CST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <b3ab186a-6941-4ea7-956f-1b8483af23ba@tessares.net>

Hello everybody!

Our public MPTCP upstreaming weekly web conference is scheduled for
tomorrow.

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20210513

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you tomorrow!
Matt

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

