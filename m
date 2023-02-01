Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67B7F
	for <mptcp@lists.linux.dev>; Wed,  1 Feb 2023 10:23:00 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id o18so7331954wrj.3
        for <mptcp@lists.linux.dev>; Wed, 01 Feb 2023 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7DA6oaWJskgMZ/nFZ8uMecM3XNfE63GqtR3b0IjpSbI=;
        b=ed0VzO4HgK5DJf39Dx3B4Jnn5Yrkyz0Ve8ymfhOU/gMMgcszLgOWpH0gwC+Oy3FIRG
         ZjXI/1pvY92n+ixh4pOCfibraJaoOgVzSZux2boTWDGjBxaisj6U8QxwJUM8VREfTzl2
         2vr8V9PJL96T/MwRWBiH441cQvJL6W1ETw0VLxFj1ionZcEya5mCx4qVp5VxASqC11aN
         BnLza4hvXqL9T/0Okr+RMIEeNOHMuvhJ3a8JhPos8lkt9epUp3diEGDebS53vv7fRCaH
         u5J8wFreCicMuPbe3P7hHY3hS3dEQK++wI5lVRySDJ06OxJQR78DTvKZ5YzmcVk2GnpG
         HgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DA6oaWJskgMZ/nFZ8uMecM3XNfE63GqtR3b0IjpSbI=;
        b=z1j3/50r5d+U6OGVKze87R2bzfZ0K5d56Sufftc3A7QbEM2UwavEDBLbaxWpwY7Spp
         G1bmSYcNLXOJz9paukXTLlHxJJyLuzyZY2KI3cq1NDRaKAePQqTP+VT3KW24RhYGg0rq
         NHNMi85sDt3K7mUdj4QSoTiGVEm/2MfxqRzGL+iVQXhKIjl1LJwOtv219eA80PGjClRN
         N9qp6LKVvHaLTY9/FerMC8NK+EKCFQ5h6/lWc9oYyif0Fg46NafKrS4t/mtf2v+eLTit
         RNVlLS70WX/CC5bdbhPv+Uf1L7YIbmNdfRBmVcBlL/Cy4hTv6dN6tPoaxV/eUdb358Y6
         TGbg==
X-Gm-Message-State: AO0yUKVRQHLWdh6CyvQcBFL2vljI2d70GmygLfeacFUrJZtYXGz4y+wL
	qcf8keKetglIQAGnQDsgU/siadiVL57wwC9aVaRCCw==
X-Google-Smtp-Source: AK7set+utBvf99ilkWSe26k2jGfP2oGt/wbmxySX3K/y4nwg1FhrFC5eYhlt8X15d2JiqtJvCD2bMA==
X-Received: by 2002:a5d:5984:0:b0:2c3:bbfa:d509 with SMTP id n4-20020a5d5984000000b002c3bbfad509mr140780wri.61.1675246978430;
        Wed, 01 Feb 2023 02:22:58 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b002bdd8f12effsm16801381wrt.30.2023.02.01.02.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:22:58 -0800 (PST)
Message-ID: <498f5acc-df60-7599-6a59-918f3a7c5027@tessares.net>
Date: Wed, 1 Feb 2023 11:22:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-net v2 1/2] selftests: mptcp: allow more slack for
 slow test-case
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
 <20230131-mptcp-issue-323-join-delete-re-add-v2-1-8de2421163c9@tessares.net>
 <CA+WQbwuB9jMnbnPKT8z0KeWT56upWOG9tKhOCPCU1f4uAkTwqA@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CA+WQbwuB9jMnbnPKT8z0KeWT56upWOG9tKhOCPCU1f4uAkTwqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 01/02/2023 06:14, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年1月31日周二 19:23写道：
>>
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> A test-case is frequently failing on some extremelly slow VMs.
>> The mptcp transfer completes before the script is able to do
>> all the required PM manipulation.
>>
>> Address the issue in the simplest possible way, making the
>> transfer even more slow.
>>
>> Additionally dump more info in case of failures, to help debugging
>> similar problems in the future.
>>
>> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/323
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 387abdcec011..52484a7c286a 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1687,6 +1687,7 @@ chk_subflow_nr()
>>         local subflow_nr=$3
>>         local cnt1
>>         local cnt2
>> +       local dump_stats
>>
>>         if [ -n "${need_title}" ]; then
>>                 printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${msg}"
>> @@ -1704,7 +1705,12 @@ chk_subflow_nr()
>>                 echo "[ ok ]"
>>         fi
>>
>> -       [ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni | grep token; ip -n $ns1 mptcp endpoint )
>> +       if [ "${dump_stats}" = 1 ]; then
>> +               ss -N $ns1 -tOni
>> +               ss -N $ns1 -tOni | grep token
>> +               ip -n $ns1 mptcp endpoint
>> +               dump_stats
>> +       fi
> 
> Hi Matt,

Thank you for the review!

> Does this work:
> 
> [ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni |
> grep token; ip -n $ns1 mptcp endpoint; dump_stats )
> 
> This is more like the original code.

This works indeed but I think it was a good idea from Paolo to switch to
a clear 'if' statement for two reasons:

- It is easier to read than having quite a few other commands on a
single line. If only 'dump_stats' function was invoked, that would have
been fine.

- If 'dump_stats' var is not 1 and because this is the last instruction
of the function, chk_subflow_nr will cause the returned code to be != 0.
That's fine here because 'set -e' is not defined and the returned code
is not checked but still, that's not ideal, better to avoid that with a
clear "if" I think.

So I think we should keep the patch as it is, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
