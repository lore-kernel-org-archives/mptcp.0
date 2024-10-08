Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B11C2420
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397263; cv=none; b=Sg3Prbr+oE55g67LFa+p1p7HCy5TIzk4w7sdF5cvhISINYszQDy2XAn7asqW4ozNWh8JXPsNxdZGWsfZcPwu+cizE3RJIpBhgTfSbGfQVK+RRLVbyCO21YoRglS0YhdFJQFjnBj0LZqI7c+xWDi99XIwa8dDsVXnZZkh28pKdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397263; c=relaxed/simple;
	bh=/CxdqqKhKqtPKcUoaynauLX6jTdDILVrF6LfSS1EW1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6OxjVYcg7tnm/k6jPMr9tK9yMVaUygJdorL9VJ1E15S/DfD9PTCW7bEmmDc06A+fjFa82U/vgXYQ4Iv9MIeyu+1BTYVEwODBoexYsZjRuWm+PetEasDc9k59vdiTkPI+b5utM6q+3ZewmaALVUCUBH1+JX19Iu+WRT6rRp+IPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSDH0xl7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSDH0xl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728397260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dg73Y+HWXo8muRA/U5h9LnDBOvTxAGR9dxi3iCPF8UE=;
	b=dSDH0xl7kOhZCEp54RiYwXI8M/+47LjoNdfakIro2yC4ay2SkzS1R/zrtfo55DgJwvCOED
	EYC5tPa9js7PTyXCbBdbfReAlIUEBpJlxz9wAndlz8ESGnwxRiFl1eKBQvnO7/qHkDwwnL
	KwHEnOGw5vw0VS4fa2qhWDijyRymTFA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-W3unF8p4NOevfh-443iPYw-1; Tue, 08 Oct 2024 10:20:59 -0400
X-MC-Unique: W3unF8p4NOevfh-443iPYw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ca8037d9aso37543855e9.3
        for <mptcp@lists.linux.dev>; Tue, 08 Oct 2024 07:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397258; x=1729002058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dg73Y+HWXo8muRA/U5h9LnDBOvTxAGR9dxi3iCPF8UE=;
        b=Vi3ltY++aNheuvo+VYzk//4hAI6LMENan7N5PsCaFCeZVuALUzU9PF0CX11vn34KDr
         rGSTg9qe/yQFU18mofpcrqiuDHfFicWyVyYt9NvGesIRDRnLS8qdK1qkP3rlIDNfQU+I
         ae3JbQdURwqs5fPMXFunMinR7qJNZ2uG5f/z3Y8z/HrahZ0sgsul8Stj7MdqcsqNHhUo
         o5ZZVHG9ByuFyZRmJ6uLYGreyjyua3UzyjlylJDtpWLE9kmI+qtg7Z4zoGg7covU4rVf
         xl1gpL6zCEazMvrQdB8TcDwx8tWoDmvBXtElHxhCva/giiwqS56GLHzaEUGhGo7rR1u9
         HDWA==
X-Gm-Message-State: AOJu0Yy2sT3dGmUfGmHi3ujdxu3/O+aywyu9fQv0zkeEI5UjKG1E/Ds1
	IEfC1qKNxfPbkU7wny8PbHJ6w1D9fu+VQLSZtxFVw8t76WIfvZB+xer3smCxNWU3ZxWL7pN9xJ9
	aqLKdfs1g19QDl3KBsH7JZDJtziVkC70zFs/5k/NkTLyaZ4AVVCyrgHZ/Eab5Ke4=
X-Received: by 2002:a7b:c454:0:b0:42c:b995:20c8 with SMTP id 5b1f17b1804b1-42f877baf34mr108527605e9.24.1728397258120;
        Tue, 08 Oct 2024 07:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbPjFeE7Nm4OXs1oCHUgf6s/KixN2t3nvOEJAOgj/SNX7RRwcmIOmIdveVhgPlGBIhTbvl8g==
X-Received: by 2002:a7b:c454:0:b0:42c:b995:20c8 with SMTP id 5b1f17b1804b1-42f877baf34mr108527485e9.24.1728397257694;
        Tue, 08 Oct 2024 07:20:57 -0700 (PDT)
Received: from [192.168.88.248] (146-241-37-211.dyn.eolo.it. [146.241.37.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4b0bfsm128508365e9.48.2024.10.08.07.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:20:57 -0700 (PDT)
Message-ID: <250cb7c2-5819-45e6-a171-9f3a50049411@redhat.com>
Date: Tue, 8 Oct 2024 16:20:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: add test-case
 for MPC attempt towards signl ep
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
 <20241007-mpc-hs-port-v2-2-0c9e7827bd0f@kernel.org>
 <dcf6cbb3-7521-4969-88d9-7f98c1afe292@redhat.com>
 <2cf1db4f-bb8c-4674-b31e-1bd6217301a7@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2cf1db4f-bb8c-4674-b31e-1bd6217301a7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 11:42, Matthieu Baerts wrote:
>> @@ -2963,6 +3008,25 @@ add_addr_ports_tests()
>>>            chk_join_nr 2 2 2
>>>            chk_add_nr 2 2 2
>>>        fi
>>> +
>>> +    if reset "port-based signal endpoint must not accept mpc"; then
>>> +        local port ret count
>>> +        port=$(get_port)
>>> +
>>> +        cond_start_capture ${ns1}
>>> +
>>> +        pm_nl_add_endpoint ${ns1} 10.0.2.1 flags signal port ${port}
>>> +        mptcp_lib_wait_local_port_listen ${ns1} ${port}
>>> +
>>> +        timeout 1 ip netns exec ${ns2} \
>>> +            ./mptcp_connect -t ${timeout_poll} -p $port -s MPTCP
>>> 10.0.2.1 >/dev/null 2>&1
>>> +        ret=$?
>>> +
>>> +        cond_stop_capture
>>> +        cat "$capout"
>>
>> Perhaps worthy to move cat "$capout" into cond_stop_capture()
> 
> I should have mentioned that in the changelog: I wanted to, but then it
> would change the behaviour for the other cases in do_transfer() where
> 'cat "$capout"' is used in 3 different places. 

Why would that change the behavior? AFAICS the 'cat "$capout" statement 
happend onece per do_transfer() invocation, just before 'return'. Moving 
it into cond_stop_capture would just reduce code duplication.

/P

