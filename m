Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA95667
	for <mptcp@lists.linux.dev>; Mon,  2 Jan 2023 16:48:48 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id m18so67669507eji.5
        for <mptcp@lists.linux.dev>; Mon, 02 Jan 2023 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jY4w4GEWCPfcfW3DS+Oq01QZ0kOrwhhjsi752PdZm4=;
        b=m4sKOgbLGAlgw/VUs+C5rqEeh2nC9K5NBTt7Lbqhz52IQmO7c20/hPudqtvwJSQxSi
         f9eCg8BxTPwGzsyS8z4v0Ux9sqrwA1srZcgbsZzWspdppX8dGwNdbPl19aBO+nXd+mTe
         1Os9sY4tIEp4Ro8MutH8Q2GsQBAhjb/jSAY47cRu3NLBplg+FlO6bz7praKOjzItcKH5
         OAUozQrUKm3pTo7R9pFpAqh9rLG6m4FCjBz1M6EffDpQrrQ2cJ0nx4qMu3oD3xoel+Ls
         0Lm7xHRW16leiyk83SbNgGVeQ3IUVL/kp8kpggFkiJU/Ew3+rGzqkz6BPDd7QZ5h8eYS
         Dk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jY4w4GEWCPfcfW3DS+Oq01QZ0kOrwhhjsi752PdZm4=;
        b=nbx3XZnW7MivUm8x8e7bQme3eev5fPK2PqLfMNqEQvmOmgjxFzBpnBp3bax1CdDLf4
         EoMY4mPXPMirILcZg1NCy+WRpOe1Ai1/5tCmY3idt02CV+hqWiRZIjyVCjzQljh3Jbo9
         k+ZdOBWf8V1X5x1osevjngs5c2Dybvjkhs6HUjdkUelZj0ByETUr/VN4Nt79QIC1VWvD
         VLCzOttZoC6/zzYKOVOpMRpaTAT3RWxVlHh5s9xEqVPDVETG4YuDbaSx51vCcnZmOIzb
         v8hmTGDnPHzeIlIjY2Jq8PnD1fc6KyV3jgkksDUYqnAP4lDVzn1CXGR7IkHfbfXQRego
         2PEg==
X-Gm-Message-State: AFqh2kq0qiMVEIZ5g9wLURhjt2e/JI3bm/+xhNImbOZwZAg7uBu4n7w3
	N5CK0FVyBwu4UD9Z+lB7Iaw5mVv0NKItiPRR
X-Google-Smtp-Source: AMrXdXuUg+EVw0QxTF3qZirz9O+BHUFZqq4hSb2/WQXukmNkP7R6zWgFCDTrdH3KbnsY9V5iBiZdig==
X-Received: by 2002:a17:907:2be8:b0:7e6:bae:fa0f with SMTP id gv40-20020a1709072be800b007e60baefa0fmr38826194ejc.58.1672678126388;
        Mon, 02 Jan 2023 08:48:46 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dt6-20020a170906b78600b0078d22b0bcf2sm13123939ejb.168.2023.01.02.08.48.46
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:48:46 -0800 (PST)
Message-ID: <fcbda329-4dee-0ada-647d-9a3c89b56f9b@tessares.net>
Date: Mon, 2 Jan 2023 17:48:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Weekly meeting - 3 January 2022 16:30 UTC (8.30am PST, 5.30pm CET,
 12.30am CST)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody!

Happy New Year!

Our public MPTCP upstreaming weekly web conference is scheduled for
*tomorrow at the (new) usual time* (16.30 UTC).

The list of topics is available here:
https://annuel2.framapad.org/p/mptcp_upstreaming_20230103

Feel free to add/modify topics!

Anybody can join the meeting using Google Meet website/app/phone:
https://meet.google.com/edk-rkrk-vaj

See/Speak to you later!
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
