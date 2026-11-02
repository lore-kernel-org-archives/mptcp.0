Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647068;
	b=anyp5l9skvkg3CZoYadW+dDixlKYAGK18bPE1Iqqpeonzj2nTnZKOUhShJpAHFuJX6BF
	 UTkdNPyBPFGMKqbDTK4wxcY5EJwTk4Y947+lySy4PwP+Dj2wnzK+4W/rnFzLbO0kbG0Vz
	 +qhtjL3w2M3m0fFvUJz9Gkggls6yYBpC9OxqvmKH7WL+cGLzxwY8J6SNduhPST3igRc5R
	 /k6qQ/c5tSfta65KYPyBTjqKURp7nvYFNzVg7X1DM1jF9RspLQlTazPqOm+fVVgVJ4Eqb
	 GNXIpGUnCOQW5egPgmjtl91Gd3NzK+Wc4Ya5IcktBuQI9Cpw8ICOpjzuHNt5cG0s7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:User-Agent:References:In-Reply-To:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
	b=T+io6lXPghuCYpeM46+0sU8mtJ+9nsxK9jvpaD5GF2Ct9/98ujXBm9L334F0f4x5LOYP
	 MpX+diTAcOO4ttZhD89JbcX9VsfxTGD1zIRO9oJu8eCqsygPCccKONzHNG9NUdpiwdAZG
	 eXwZVPlSA/qwDbNkbTDtCib677JD+PtVY1nCx4wzVHwOyiBr/1+TBN8qSpGkRFUEWn3Kj
	 KqPgnRehOvQ4624PMHdNV60ugl3cjzWJi9CUcHcVtXurITjGWtCTrkTzx6/6s+Xxru5n1
	 goJh9JxGucL8eGrXf/qF9B/aqWPbFBBYgRr9Q+d6BWNtCjwN8PQoMrC6qNNuOL94tmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5MSW86q;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D99606A327
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 19:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39D99606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5MSW86q
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ea7987517aso22612075ad.0
        for <mptcp@lists.linux.dev>; Mon, 02 Nov 2026 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647066; x=1794251866; darn=lists.linux.dev;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
        b=h5MSW86qEWcbfsjZkbooHqp10Q7qgt2ttpnS7WmAeg+uyi+FxxNlFllfbdUPvjR+yw
         BLaqozjgUr24pH8A2yVpuYlMXJUDkzQswnHItykvKVV3Ab6kAlYuC0jLGQfAnF9QYD5g
         B+ege83crHus0PjkGFAUSNF5Z5Fkbdc5jPH/KOls3mTKtKn2jvGz+R4wS4HBbIzTAmwf
         KSfSukqtkdWA12jhTVxBwmspErm2oYarq6poANHbPI7Kf9YT3dCEUc10fXche4Z/WbuQ
         sI/KQdr9UBtBdjvyed+Dwt0/dptnCl3ptEu7NXI39FXclsYwqn8LjlmArUgqXrb9TaT9
         cPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647066; x=1794251866;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4HU1ZMjQSDjg4zY71Jjjfa2oalRN5eFdZ16rR5uBtk=;
        b=vZgC4a7Y5SJXdXn/yOy8Jm/vrhEnwYywxxyZE37GhqBG5Uf7ZI5hzwfu+VjLewnCKL
         qRjfgEuaoEYy2wiWOESnwEHyz/irjePsYUy0vozMPdhKQso9661hSGRKyNulOysuZvNr
         aZCFWr4ktRjXSNcp5JnKQxLjPndpkBGUv1E3MFsJmv3yYNRGlvlsngfxFm2C67iHpG4b
         rChL+MLns+VUPxk83BEsKM4DKh2+frrFpc71fa08C+yLeoGkUAHextlcav3HULBPLC11
         Ih09HrZZ0KegbasrAvBhtpF2rrM9wIRAhfiiFGoagrAbOPjqBrjpSo1lIhNDSsUElisp
         laVA==
X-Gm-Message-State: APuU4Z/0d/5Pu1oIMPajN5Erfd5D9eHVG5f4DZydw6AXpm8OYqBp7Sc2
	xA4U+nViO+sDyWGnaQZFE+TCMdvqZ7vtsPfDkQvziM10UWAZ68GBvvaeYE43IA==
X-Gm-Gg: AYBFou1+jBQjn6js9AxDfXS2YRx6jwtzZGfkCbVFVHoAzGtysUTOw/CVpwJTMGEWUVl
	ltlLUkv6saeKeFgNestzaxyG5KoHrbs5X5YM0+cZKKPw/FXbG/wwKnuAsCWGwHQ/S6sxj8Mg1GC
	csEUrBgtNqYpQ340pZ/xGFzXYocs64NbNb7nQ/EtCZl/OZ1BNjA2K+16BqQL+EEW0vjcYl3J7HD
	rZyWMKLNhChYdwBf23Tul4xMaPg8YgXsMVYK4us4dL05/UEW3SydL4P1UIkcyix6TN3R0jCH5EJ
	KIp9YOw+2S6KXhHLZ7rROWmR80r2AtxnaGLrgC9JZByl1LxiGuS+ol/dQqzFKc57eUeyqO+D7ki
	m2wRircdltiqo1C3j72mitzYxclzAbAF+CyBEyuxa+0GWu7Knnm38yE/AUwfvQxWTTgSytZFOqh
	Ood8uTtaEOtYIbIBYDQtvxO9YnXzBll3GwUpnAdqRyS4HMAjXaLbGR5Rspsr3jMPLCX//YH49N5
	Q53HUXOt1uO8r/pqbh7pHcbpHt9Xx0jCRMHf9sQiOf6fZ5OamN5Jxwn7hiCOzzNzBXBwb4uumiV
	eiXmRvWK7tSIP2EX3J8ZIeUNttDI1OV25gnOxUtCE+mIoZiD1yqmtRgGfbRtEve0Ly3c
X-Received: by 2002:a17:903:1b2c:b0:2ea:a2ea:5f62 with SMTP id d9443c01a7336-2eb364b8c96mr101881445ad.24.1793647066596;
        Mon, 02 Nov 2026 11:17:46 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39231422sm32617295ad.23.2026.11.02.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:17:46 -0800 (PST)
Date: Mon, 02 Nov 2026 12:16:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a stopped psock
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-6-alexei.starovoitov@gmail.com> <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
In-Reply-To: <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
Message-ID: <tnw2xl.1p1r2tdvgc3bg@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 04:40, Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>
>On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
>> the psock. When the socket has no room, the function saves the length and
>> offset of the remaining data in psock->work_state. A later run continues at
>> this offset and clears the state when the skb is complete.
>>
>> sk_psock_skb_state() saves and clears the state, but only while
>> SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
>> each skb. If the socket closes during the loop, sk_psock_stop() clears the
>> flag. The loop continues, but the state of the completed skb stays. The
>> loop uses this state for all subsequent skbs and sends only part of their
>> data. A closing socket may lose the end of a stream, but not the middle.
>>
>> The state belongs to the skb at the head of ingress_skb. Always clear the
>> state when this skb is complete. A stopped psock still saves no new state.
>>
>> Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  net/core/skmsg.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index f03519468ad1..a5d498982848 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
>>  			       int len, int off)
>>  {
>>  	spin_lock_bh(&psock->ingress_lock);
>> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>> +	/* No new state once the psock is stopped, but never keep an old one */
>> +	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>>  		state->len = len;
>>  		state->off = off;
>>  	}
>
>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
