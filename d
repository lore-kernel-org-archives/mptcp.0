Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31306E
	for <mptcp@lists.linux.dev>; Fri, 19 Mar 2021 15:32:23 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id g15so3260387qkl.4
        for <mptcp@lists.linux.dev>; Fri, 19 Mar 2021 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Eg/Ac3Kmlnz0vuCOQ+y7mHAscoEIVLKU//VoOFUyH9A=;
        b=ZkEubUo+ORBycYSEKkEkaoxSAKARrcC9fxxb9L25bS29+NAL1m2IuUtbj5nlSe9vkB
         AZQjHwyCwsqd4drkzB3vrlS9FeC8oUagM04PMK693GmJS+Q7c7whHYcPgSB4QvSevnn1
         h4U8ilkuYlP3HrRtk1POunQEHT0SD4bG4R7jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Eg/Ac3Kmlnz0vuCOQ+y7mHAscoEIVLKU//VoOFUyH9A=;
        b=fsyQmb8QPd20vGq7bdZi3ejIWgAx5sl1Za4wcuO2sMeHjDowzw2yhHcFGDPzq59FzH
         JgAyJl43nsp1G2jV2AjvwkCzV7nicDgfk2DU7x8x7Kn2FRxn4T0ZP81Z/Hq8lCpooMcq
         KpLVJEUUTrtHYEHZw+EWIsEe1oitaiNDHZ2MBlJlmtCiPUBx0NnNVjfcCa8RZUCy1fHh
         7OgVqfUFcC28Ixo1f+HFKPbDz08Bqkly4wh2YiVo2cwgIiSXmQL5fKymdaM/jGVlc1OW
         3MALAQfr9iWMXkmD7inO9vLDByzVz+qTj3H35OnGCVxhQcC0iEx7KOvwxc7upeQq4oW/
         jhiQ==
X-Gm-Message-State: AOAM530VR+ngou8bxGc2LvpMy8+7PPSi7plfH2/NSBGZjOmsVD1/s8VI
	7krTAiq5p5H+sS45VCbcPQMlI/unbEcFIsieZEY=
X-Google-Smtp-Source: ABdhPJy5PeB92YVM5eIAAK8dkJghJmT2wnsjqgNiWAocJN7RNxQvWaZvcYREgtz9caRhmba/A3b8kg==
X-Received: by 2002:a37:a0ca:: with SMTP id j193mr10058890qke.242.1616167942309;
        Fri, 19 Mar 2021 08:32:22 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g74sm4535331qke.3.2021.03.19.08.32.21
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:32:21 -0700 (PDT)
Date: Fri, 19 Mar 2021 11:32:19 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: mptcp@lists.linux.dev
Subject: Test delivery to the new list
Message-ID: <20210319153219.wuanugqtretiymww@chatter.i7.local>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Please ignore, testing delivery.

-K
