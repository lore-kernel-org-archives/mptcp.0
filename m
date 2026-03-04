Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB44352FBA
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616295; cv=none; b=NAWjyLr3aW9TFHbsU0VbGdoZhmWh4+xIjsNpx2GlLPRJazs3TczfO4LMEGVn+pvBQyBUL1XdjVsiXaiKBWZyDUy2pG59ZxN4rsJTDQTMjevrc/T7Tu3i+NvJtuxpP8Q3frx+AccdLtuG4FTac+ETK32b1PdTVMZH9pixhm8sfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616295; c=relaxed/simple;
	bh=MVQhcGBn6YW7ExDvSL0VET30MB3SKZt+vNQgsoR9ju0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=te2IbjnEQ5/wvlJgnbOuPhmyQw0F7Nc0M79CLtV1X3eT+hLOM26sQXDxKIds+5kanuZVma0ZApRLMFe8le4KNlxxae8OGR/PZ3YAinOqJ4AnFxiSk8vfGOB82fqDh7F7qmWXo4CkkzJd29ZttD05tyjr6oxRW6hnljmqZCc/z08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=i7x4nBGo; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="i7x4nBGo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JNYzYS3a/7M1z++lKGXx05x1L7768oI/UUytgZ80oNY=;
	b=i7x4nBGoHTL9c2BCZecME8ZeikLulrQT3xjh3bT0NQwYhQ8SdEWlryY8lXA8GdqGG8PEiDKsy
	sfkxlISK07oo+K/+46AqSBdzsvZhkTBU6KSrChkLYpHLsJb2FOj9Cz6XFwAu+x4PtlUDwxz6tSt
	ze9MUoy5uny1MILtoag1cig=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fQnFC633KzRhT3;
	Wed,  4 Mar 2026 17:19:59 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C4C240569;
	Wed,  4 Mar 2026 17:24:50 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 17:24:49 +0800
Message-ID: <e91bf909-bf4d-4f90-a370-688a9424478b@huawei.com>
Date: Wed, 4 Mar 2026 17:24:48 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
To: Matthieu Baerts <matttbe@kernel.org>
CC: <geliang@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<martineau@kernel.org>, <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
 <57061768-a136-49b8-b020-609016f217ed@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <57061768-a136-49b8-b020-609016f217ed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Matt,

On 3/4/2026 2:06 AM, Matthieu Baerts wrote:
> Hi Li,
> 
> On 02/03/2026 06:26, Li Xiasong wrote:
>> syzbot reported a soft lockup in mptcp_recvmsg() [0].
>>
>> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
>> removed from the sk_receive_queue. This causes sk_wait_data() to always
>> find available data and never perform actual waiting, leading to a soft
>> lockup.
>>
>> Fix this by adding a 'last' parameter to track the last peeked skb.
>> This allows sk_wait_data() to make informed waiting decisions and prevent
>> infinite loops when MSG_PEEK is used.
> 
> (...)
> 
>> Fixes: 612f71d7328c ("mptcp: fix possible stall on recvmsg()")
>> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
>> ---
>>  net/mptcp/protocol.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index cf1852b99963..7a65c2101f63 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>  				size_t len, int flags, int copied_total,
>>  				struct scm_timestamping_internal *tss,
>> -				int *cmsg_flags)
>> +				int *cmsg_flags, struct sk_buff **last)
>>  {
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>  	struct sk_buff *skb, *tmp;
>> @@ -2058,6 +2058,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>  			}
>>  
>>  			mptcp_eat_recv_skb(sk, skb);
>> +		} else {
>> +			*last = skb;
> 
> Out of curiosity, why only setting *last for MSG_PEEK? Is it not better
> to always call sk_wait_data() later with the last skb, even when
> MSG_PEEK is not used?
> 
> Or will this cause other troubles?


Yes, unconditionally updating last (like tcp_recvmsg_locked) makes
sense. The current hesitation is due to mptcp_eat_recv_skb releasing the
skb in non-MSG_PEEK cases—if the address is reused, keeping a last
pointer could lead to misjudgment.

> 
>>  		}
>>  
>>  		if (copied >= len)
>> @@ -2263,6 +2265,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  {
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>  	struct scm_timestamping_internal tss;
>> +	struct sk_buff *last = NULL;
> 
> Detail: the scope of this variable could eventually be reduced by moving
> it inside the while-loop. This should hopefully help to reduce conflicts
> during backports.
> 


You're right. My initial thought was to move `last` into the while loop,
but in practice, to retain the last MSG_PEEK skb, `last` must be updated
very early in __mptcp_recvmsg_mskq as we begin traversing
&sk->sk_receive_queue. The issue is that if a subsequent step fails—such
as skb_copy_datagram_msg—we'd then need to roll `last` back to the
previous skb, which adds significant complexity. This suggests the
current approach may be the safer trade-off.

>>  	int copied = 0, cmsg_flags = 0;
>>  	int target;
>>  	long timeo;
>> @@ -2291,7 +2294,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  		int err, bytes_read;
>>  
>>  		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
>> -						  copied, &tss, &cmsg_flags);
>> +						  copied, &tss, &cmsg_flags,
>> +						  &last);
>>  		if (unlikely(bytes_read < 0)) {
>>  			if (!copied)
>>  				copied = bytes_read;
>> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  
>>  		pr_debug("block timeout %ld\n", timeo);
>>  		mptcp_cleanup_rbuf(msk, copied);
>> -		err = sk_wait_data(sk, &timeo, NULL);
>> +		err = sk_wait_data(sk, &timeo, last);
>>  		if (err < 0) {
>>  			err = copied ? : err;
>>  			goto out_err;
> Cheers,
> Matt


As requested, here are the two minimal test programs.

Steps to reproduce
1.Save as client.c and server.c.

2.Compile:
    gcc client.c -o client
    gcc server.c -o server

3.Run ./server, then ./client in another terminal.

--- client.c ---

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <time.h>
#include <errno.h>

#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif

#define PORT 8888

int main() {
    int sock_fd;
    struct sockaddr_in server_addr;
    int enable = 1;

    if ((sock_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP)) < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }
    printf("Created MPTCP socket\n");

    if (setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &enable,
sizeof(enable)) < 0) {
        perror("Setsockopt SO_REUSEADDR failed");
        close(sock_fd);
        exit(EXIT_FAILURE);
    }

    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");

    printf("Connecting to 127.0.0.1:%d...\n", PORT);
    if (connect(sock_fd, (struct sockaddr*)&server_addr,
sizeof(server_addr)) < 0) {
        perror("Connection failed");
        close(sock_fd);
        exit(EXIT_FAILURE);
    }
    printf("Connected successfully\n");

    sleep(3);
    printf("\nStarting data transmission test...\n");

    send(sock_fd, "A", 1, 0);

    while (1) {
        sleep(1); // wait
    }

    close(sock_fd);

    printf("Bye!\n");
    return 0;
}

--- client.c ends ---

--- server.c ---

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <errno.h>
#include <signal.h>

#define PORT 8888
#define BUFFER_SIZE 1024
#define BACKLOG 5

#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif

int sock_fd = -1;
int client_fd = -1;

void handle_signal(int sig) {
    printf("\nSignal %d received, cleaning up...\n", sig);
    if (client_fd > 0) close(client_fd);
    if (sock_fd > 0) close(sock_fd);
    exit(0);
}

int main() {
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);
    char buffer[BUFFER_SIZE];
    int enable = 1;
    long total_received = 0;
    long long start_time = 0;

    signal(SIGINT, handle_signal);
    signal(SIGTERM, handle_signal);

    if ((sock_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP)) < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }
    printf("Created MPTCP socket\n");

    if (setsockopt(sock_fd, SOL_SOCKET, SO_REUSEADDR, &enable,
sizeof(enable)) < 0) {
        perror("Setsockopt SO_REUSEADDR failed");
        close(sock_fd);
        exit(EXIT_FAILURE);
    }

    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(PORT);
    server_addr.sin_addr.s_addr = INADDR_ANY;

    if (bind(sock_fd, (struct sockaddr*)&server_addr,
sizeof(server_addr)) < 0) {
        perror("Bind failed");
        close(sock_fd);
        exit(EXIT_FAILURE);
    }
    printf("Bound to port %d\n", PORT);

    if (listen(sock_fd, BACKLOG) < 0) {
        perror("Listen failed");
        close(sock_fd);
        exit(EXIT_FAILURE);
    }
    printf("Listening for MPTCP connections...\n");

    client_fd = accept(sock_fd, (struct sockaddr*)&client_addr,
&client_len);
    if (client_fd < 0) {
        perror("Accept failed");
        close(sock_fd);
        exit(EXIT_FAILURE);
    }
    printf("Client connected from %s:%d\n",
           inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

    printf("\nWaiting for data...\n");

    while (1) {
        int bytes_received = recv(client_fd, buffer, BUFFER_SIZE - 1,
MSG_PEEK | MSG_WAITALL);
        if (bytes_received <= 0) {
            // Just break out
            break;
        }
        printf("Receive bytes size %d\n", bytes_received);
    }

    close(client_fd);
    close(sock_fd);
    return 0;
}

--- server.c ends ---

Best regards,
Li Xiasong




